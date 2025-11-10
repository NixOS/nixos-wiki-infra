#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR

set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source logging functions
source "${SCRIPT_DIR}/logging.sh"

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

# Source health checks
source "${SCRIPT_DIR}/health_checks.sh"

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
  CURRENT_GENERATION=$(ssh "${SSH_TARGET}" "nix-env --list-generations -p /nix/var/nix/profiles/system | tail -1 | awk '{print \$1}'")
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
  nixBuild .#checks.x86_64-linux.test .#nixosConfigurations.nixos-wiki-nixos-org.config.system.build.toplevel -L
}

# Deploy with retries
deploy_system() {
  log "Deploying to ${WIKI_HOST}..."

  local retry_count=0
  while [ $retry_count -lt $MAX_RETRIES ]; do
    if nixos-rebuild-ng switch ----use-substitutes --flake "${FLAKE_TARGET}" --target-host "${SSH_TARGET}"; then
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
  log "Running post-deployment health checks..."
  export WAIT_FOR_STABILIZATION=true
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
