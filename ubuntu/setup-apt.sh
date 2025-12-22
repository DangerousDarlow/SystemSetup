#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Updating apt repositories"
sudo apt update || { show_error "Failed to update apt repositories"; exit 1; }

show_info "Upgrading installed packages"
sudo apt full-upgrade -y || { show_error "Failed to upgrade installed packages"; exit 1; }

show_info "Removing unnecessary packages"
sudo apt autoremove -y || { show_error "Failed to remove unnecessary packages"; exit 1; }

show_info "Installing common utilities"
sudo apt install curl git vim wget zip unzip zsh -y || { show_error "Failed to install common utilities"; exit 1; }

show_success "apt setup completed successfully"