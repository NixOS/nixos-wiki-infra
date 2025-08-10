#!/usr/bin/env bash
# shellcheck shell=bash

# Shared logging functions for NixOS Wiki scripts
# This file should be sourced by other scripts

# Colors for output
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export NC='\033[0m' # No Color

# Basic logging functions
log() {
  echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $*"
}

error() {
  echo -e "${RED}[ERROR $(date '+%Y-%m-%d %H:%M:%S')]${NC} $*" >&2
}

warning() {
  echo -e "${YELLOW}[WARNING $(date '+%Y-%m-%d %H:%M:%S')]${NC} $*"
}
