#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Installing GitHub CLI"	
sudo apt install gh -y || { show_error "Failed to install GitHub CLI"; exit 1; }

show_info "Configuring git"
git config --global user.name "Nick Darlow"
git config --global user.email "dangerous.darlow@gmail.com" 
git config --global core.autocrlf input

show_success "GitHub CLI installation completed successfully"