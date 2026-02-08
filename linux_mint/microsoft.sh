#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Installing Microsoft tools"
sudo apt install -y \
    powershell \
    azure-functions-core-tools-4 || { show_error "Failed to install Microsoft tools"; exit 1; }

show_success "Microsoft tools installed successfully"