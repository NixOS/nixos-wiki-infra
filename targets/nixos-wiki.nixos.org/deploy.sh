#!/usr/bin/env bash

set -euo pipefail

WIKI_HOST="wiki.nixos.org"
SSH_TARGET="root@${WIKI_HOST}"
FLAKE_TARGET=".#nixos-wiki-nixos-org"
MAX_RETRIES=3
ROLLBACK_ON_FAILURE=true

# nixos-rebuild-ng handles its own SSH ControlMaster, so we just set up
# a wrapper for our own SSH calls to reduce authentication prompts
SSH_TMPDIR=$(mktemp -d /tmp/wiki-deploy.XXXXXX)
trap 'rm -rf "$SSH_TMPDIR"' EXIT

# SSH options for our direct SSH calls (not nixos-rebuild-ng)
SSH_CONTROL_PATH="${SSH_TMPDIR}/ssh-%h"
SSH_OPTS="-o ControlMaster=auto -o ControlPath=${SSH_CONTROL_PATH} -o ControlPersist=30s"

# Function to use SSH with our options
ssh() {
  # shellcheck disable=SC2086
  command ssh ${SSH_OPTS} "$@"
}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
  echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $*"
}

error() {
  echo -e "${RED}[ERROR $(date '+%Y-%m-%d %H:%M:%S')]${NC} $*" >&2
}

warning() {
  echo -e "${YELLOW}[WARNING $(date '+%Y-%m-%d %H:%M:%S')]${NC} $*"
}

nixBuild() {
  if command -v nom -v &>/dev/null; then
    nom build "$@"
  else
    nix build "$@"
  fi
}

# Pre-deployment checks
pre_deployment_checks() {
  log "Running pre-deployment checks..."

  # Check SSH connectivity
  log "Checking SSH connectivity to ${WIKI_HOST}..."
  if ! ssh -o ConnectTimeout=10 "${SSH_TARGET}" "echo 'SSH connection successful'"; then
    error "Cannot establish SSH connection to ${WIKI_HOST}"
    return 1
  fi

  # Get current system generation for potential rollback
  CURRENT_GENERATION=$(ssh "${SSH_TARGET}" "readlink /run/current-system | sed 's/.*-\([0-9]*\)-link/\1/'")
  log "Current system generation: ${CURRENT_GENERATION}"

  # Check disk space
  log "Checking disk space on target..."
  DISK_USAGE=$(ssh "${SSH_TARGET}" "df -h / | awk 'NR==2 {print \$5}' | sed 's/%//'")
  if [ "${DISK_USAGE}" -gt 85 ]; then
    warning "Disk usage is high: ${DISK_USAGE}%"
  fi

  return 0
}

# Build the system
build_system() {
  log "Building NixOS configuration..."
  nixBuild .#checks.x86_64-linux.test .#nixosConfigurations.nixos-wiki-nixos-org.config.system.build.toplevel -L --log-format bar-with-logs
}

# Deploy with retries
deploy_system() {
  log "Deploying to ${WIKI_HOST}..."

  local retry_count=0
  while [ $retry_count -lt $MAX_RETRIES ]; do
    if nixos-rebuild-ng switch --flake "${FLAKE_TARGET}" --target-host "${SSH_TARGET}"; then
      log "Deployment successful"
      return 0
    else
      retry_count=$((retry_count + 1))
      if [ $retry_count -lt $MAX_RETRIES ]; then
        warning "Deployment failed, retrying ($retry_count/$MAX_RETRIES)..."
        sleep 5
      fi
    fi
  done

  error "Deployment failed after $MAX_RETRIES attempts"
  return 1
}

# Health check functions
check_nginx() {
  log "Checking nginx service..."
  if ! ssh "${SSH_TARGET}" "systemctl is-active --quiet nginx"; then
    error "Nginx service is not active"
    ssh "${SSH_TARGET}" "systemctl status nginx --no-pager | head -20" || true
    return 1
  fi

  # Check if main page loads with wiki content
  local response_code
  local response_body
  response_code=$(curl -sL -o /dev/null -w "%{http_code}" -m 10 "https://${WIKI_HOST}/wiki/Main_Page" || echo "000")

  if [[ $response_code != "200" ]]; then
    error "Main page returned HTTP status code: $response_code"
    if [[ $response_code == "000" ]]; then
      error "Failed to connect to https://${WIKI_HOST}/wiki/Main_Page"
    fi
    return 1
  fi

  # Check page content (follow redirects)
  response_body=$(curl -sfL -m 10 "https://${WIKI_HOST}/wiki/Main_Page" 2>&1) || {
    error "Failed to fetch main page content: $?"
    return 1
  }

  if ! echo "$response_body" | grep -q "<title>.*NixOS Wiki.*</title>"; then
    error "Main page does not contain expected title"
    error "Page title: $(echo "$response_body" | grep -o '<title>[^<]*</title>' | head -1 || echo "Could not extract title")"
    error "First 500 chars of response:"
    echo "$response_body" | head -c 500
    return 1
  fi

  return 0
}

check_postgresql() {
  log "Checking PostgreSQL service..."
  ssh "${SSH_TARGET}" "systemctl is-active --quiet postgresql" || return 1

  # Check if database is accessible
  if ! ssh "${SSH_TARGET}" "sudo -u postgres psql -d mediawiki -c 'SELECT 1;' >/dev/null 2>&1"; then
    error "PostgreSQL database 'mediawiki' is not accessible"
    return 1
  fi
  return 0
}

check_postfix() {
  log "Checking Postfix service..."
  if ! ssh "${SSH_TARGET}" "systemctl is-active --quiet postfix"; then
    error "Postfix service is not active"
    return 1
  fi

  # Check if postfix queue is processing (not stuck)
  local queue_status
  queue_status=$(ssh "${SSH_TARGET}" "postqueue -p | tail -1" 2>&1)
  if echo "$queue_status" | grep -q "Mail queue is empty"; then
    log "  Postfix queue is empty (good)"
  elif echo "$queue_status" | grep -q "in .*[0-9]* Request"; then
    local queue_count
    queue_count=$(echo "$queue_status" | grep -o '[0-9]*' | head -1)
    if [ "${queue_count:-0}" -gt 50 ]; then
      warning "  Postfix has many queued emails: $queue_status"
    else
      log "  Postfix has $queue_count queued email(s) (acceptable)"
    fi
  else
    warning "  Could not determine postfix queue status"
  fi

  return 0
}

check_backup_services() {
  log "Checking backup services..."

  # Check if backup timers are active
  local backup_services=("wiki-dump.timer" "borgbackup-job-wiki.timer")
  for service in "${backup_services[@]}"; do
    # shellcheck disable=SC2029
    if ssh "${SSH_TARGET}" "systemctl is-active --quiet '$service'"; then
      log "  ✓ $service is active"
    else
      warning "  ✗ $service is not active"
    fi
  done
  return 0
}

# Main health check
run_health_checks() {
  log "Running post-deployment health checks..."

  local failed_checks=0
  local start_time
  start_time=$(date +%s)

  # Wait for system to stabilize
  log "Waiting for system to stabilize..."
  sleep 10

  # Run individual health checks
  local checks=(
    "check_nginx"
    "check_postgresql"
    "check_postfix"
    "check_backup_services"
  )

  for check in "${checks[@]}"; do
    if $check; then
      log "  ✓ $check passed"
    else
      error "  ✗ $check failed"
      failed_checks=$((failed_checks + 1))
    fi
  done

  # Check overall system status
  log "Checking overall system status..."
  local system_status
  system_status=$(ssh "${SSH_TARGET}" "systemctl is-system-running || echo 'degraded'")

  if [[ $system_status == "running" ]]; then
    log "System status: running"
  else
    warning "System status: $system_status"
    if [[ $system_status == "degraded" ]]; then
      log "Failed units:"
      ssh "${SSH_TARGET}" "systemctl --failed --no-pager"
    fi
  fi

  local elapsed=$(($(date +%s) - start_time))
  log "Health checks completed in ${elapsed}s"

  if [ $failed_checks -gt 0 ]; then
    error "$failed_checks health checks failed"
    return 1
  fi

  return 0
}

# Rollback function
rollback() {
  if [ -z "${CURRENT_GENERATION:-}" ]; then
    error "Cannot rollback: no previous generation recorded"
    return 1
  fi

  error "Rolling back to generation ${CURRENT_GENERATION}..."
  # shellcheck disable=SC2029
  if ssh "${SSH_TARGET}" "nix-env --profile /nix/var/nix/profiles/system --switch-generation '${CURRENT_GENERATION}' && /nix/var/nix/profiles/system/bin/switch-to-configuration switch"; then
    log "Rollback successful"
    return 0
  else
    error "Rollback failed!"
    return 1
  fi
}

# Main deployment flow
main() {
  log "Starting NixOS Wiki deployment..."

  # Build
  if ! build_system; then
    error "Build failed, aborting"
    exit 1
  fi

  # Pre-deployment checks
  if ! pre_deployment_checks; then
    error "Pre-deployment checks failed, aborting"
    exit 1
  fi

  # Deploy
  deploy_success=true
  if ! deploy_system; then
    error "Deployment failed"
    deploy_success=false
  fi

  # Always run health checks to see current system state
  if ! run_health_checks; then
    error "Post-deployment health checks failed"

    if [ "$ROLLBACK_ON_FAILURE" = true ]; then
      warning "Attempting automatic rollback..."
      if rollback; then
        log "Rollback completed. Please investigate the deployment failure."
        exit 1
      else
        error "Automatic rollback failed! Manual intervention required!"
        exit 2
      fi
    else
      error "Health checks failed but rollback is disabled"
      exit 1
    fi
  fi

  # If deployment failed but health checks passed, still exit with error
  if [ "$deploy_success" = false ]; then
    error "Deployment failed but system appears healthy"
    exit 1
  fi

  log "Deployment completed successfully! 🚀"
  log "NixOS Wiki is healthy at https://${WIKI_HOST}"
}

# Run main function
main "$@"
