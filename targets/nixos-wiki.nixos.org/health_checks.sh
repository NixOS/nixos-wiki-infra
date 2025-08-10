#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR

# Health check functions for NixOS Wiki
# This file can be sourced by other scripts

set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source logging functions
source "${SCRIPT_DIR}/logging.sh"

# Required variables that should be set by the calling script
: "${WIKI_HOST:=wiki.nixos.org}"
: "${SSH_TARGET:=root@${WIKI_HOST}}"

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

# Main health check runner
run_health_checks() {
  log "Running health checks..."

  local failed_checks=0
  local start_time
  start_time=$(date +%s)

  # Wait for system to stabilize if requested
  if [ "${WAIT_FOR_STABILIZATION:-true}" = "true" ]; then
    log "Waiting for system to stabilize..."
    sleep 10
  fi

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

# Function to wait for SSH connectivity
wait_for_ssh() {
  local max_attempts="${1:-30}"
  local wait_time="${2:-10}"
  local attempt=0

  log "Waiting for SSH connectivity to ${WIKI_HOST}..."

  while [ $attempt -lt "$max_attempts" ]; do
    if ssh -o ConnectTimeout=5 -o BatchMode=yes "${SSH_TARGET}" "echo 'SSH connection successful'" &>/dev/null; then
      log "SSH connection established after $((attempt * wait_time)) seconds"
      return 0
    fi

    attempt=$((attempt + 1))
    if [ $attempt -lt "$max_attempts" ]; then
      log "  Attempt $attempt/$max_attempts failed, waiting ${wait_time}s..."
      sleep "$wait_time"
    fi
  done

  error "Failed to establish SSH connection after $((max_attempts * wait_time)) seconds"
  return 1
}
