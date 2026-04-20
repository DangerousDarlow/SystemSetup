#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Installing post sources apt packages"
sudo apt install -y \
  naps2 || { show_error "Failed to install post sources apt packages"; exit 1; }