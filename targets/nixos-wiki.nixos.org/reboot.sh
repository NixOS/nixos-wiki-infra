#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR

set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source logging functions
source "${SCRIPT_DIR}/logging.sh"

WIKI_HOST="wiki.nixos.org"
SSH_TARGET="root@${WIKI_HOST}"
MAX_SSH_WAIT_ATTEMPTS=30 # 30 attempts * 10 seconds = 5 minutes max wait
SSH_WAIT_INTERVAL=10

# SSH options for our direct SSH calls
SSH_TMPDIR=$(mktemp -d /tmp/wiki-reboot.XXXXXX)
trap 'rm -rf "$SSH_TMPDIR"' EXIT

SSH_CONTROL_PATH="${SSH_TMPDIR}/ssh-%h"
SSH_OPTS="-o ControlMaster=auto -o ControlPath=${SSH_CONTROL_PATH} -o ControlPersist=30s"

# Function to use SSH with our options
ssh() {
  # shellcheck disable=SC2086
  command ssh ${SSH_OPTS} "$@"
}

# Source health checks
source "${SCRIPT_DIR}/health_checks.sh"

# Function to get system uptime in seconds
get_uptime_seconds() {
  ssh "${SSH_TARGET}" "cat /proc/uptime | cut -d' ' -f1 | cut -d'.' -f1" 2>/dev/null || echo "0"
}

# Pre-reboot checks
pre_reboot_checks() {
  log "Running pre-reboot checks..."

  # Check SSH connectivity
  log "Checking SSH connectivity to ${WIKI_HOST}..."
  if ! ssh -o ConnectTimeout=10 "${SSH_TARGET}" "echo 'SSH connection successful'"; then
    error "Cannot establish SSH connection to ${WIKI_HOST}"
    return 1
  fi

  # Get current uptime for comparison after reboot
  UPTIME_BEFORE=$(get_uptime_seconds)
  log "Current system uptime: ${UPTIME_BEFORE} seconds"

  # Quick health check before reboot
  log "Running quick health check before reboot..."
  export WAIT_FOR_STABILIZATION=false
  if ! run_health_checks; then
    warning "System has issues before reboot, but proceeding anyway"
  fi

  return 0
}

# Initiate reboot
initiate_reboot() {
  log "Initiating system reboot..."

  # Use shutdown -r now for a clean reboot
  if ! ssh "${SSH_TARGET}" "shutdown -r now" 2>/dev/null; then
    # Connection might drop immediately, which is expected
    log "Reboot command sent (connection may have dropped)"
  fi

  # Give system time to start shutting down
  sleep 5
}

# Wait for system to come back online
wait_for_system_online() {
  log "Waiting for system to come back online..."

  # First, wait for SSH to stop responding (system going down)
  local down_confirmed=false
  for _i in {1..10}; do
    if ! ssh -o ConnectTimeout=2 -o BatchMode=yes "${SSH_TARGET}" "true" &>/dev/null; then
      down_confirmed=true
      log "System appears to be rebooting (SSH not responding)"
      break
    fi
    sleep 2
  done

  if [ "$down_confirmed" = false ]; then
    warning "System may not have rebooted properly (SSH still responding)"
  fi

  # Now wait for SSH to come back
  if ! wait_for_ssh "$MAX_SSH_WAIT_ATTEMPTS" "$SSH_WAIT_INTERVAL"; then
    error "System did not come back online within expected time"
    return 1
  fi

  # Verify reboot actually happened by checking uptime
  local uptime_after
  uptime_after=$(get_uptime_seconds)

  if [ "$uptime_after" -lt 300 ]; then
    log "System successfully rebooted (uptime: ${uptime_after} seconds)"
  else
    warning "System uptime is ${uptime_after} seconds - reboot may not have occurred"
    warning "Continuing with health checks anyway..."
  fi

  return 0
}

# Main reboot flow
main() {
  log "Starting NixOS Wiki reboot procedure..."

  # Pre-reboot checks
  if ! pre_reboot_checks; then
    error "Pre-reboot checks failed, aborting"
    exit 1
  fi

  # Log reboot action
  log "Rebooting the production NixOS Wiki server..."

  # Initiate reboot
  initiate_reboot

  # Wait for system to come back
  if ! wait_for_system_online; then
    error "Failed to confirm system is back online"
    error "Manual intervention may be required!"
    exit 1
  fi

  # Run post-reboot health checks
  log "Running post-reboot health checks..."
  export WAIT_FOR_STABILIZATION=true
  if ! run_health_checks; then
    error "Post-reboot health checks failed!"
    error "System is online but may not be functioning correctly"
    error "Please investigate immediately!"
    exit 1
  fi

  log "Reboot completed successfully! 🚀"
  log "NixOS Wiki is healthy at https://${WIKI_HOST}"
}

# Run main function
main "$@"
