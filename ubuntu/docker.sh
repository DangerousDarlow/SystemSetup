#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

# Determine if script is being run at top level or sourced
# Must be done at script level, not inside a function
if [[ "$ZSH_EVAL_CONTEXT" == "toplevel" ]]; then
    IS_TOP_LEVEL=true
else
    IS_TOP_LEVEL=false
fi

# Check if Docker is already installed
if command -v docker &> /dev/null; then
	show_info "Docker is already installed"
	$IS_TOP_LEVEL && exit 0 || return 0
fi

show_info "Installing Docker packages"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || {
	show_error "Failed to install Docker packages"
	exit 1
}

show_info "Adding user to docker group"
sudo usermod -aG docker "$USER" || {
	show_error "Failed to add user to docker group"
	exit 1
}

show_success "Docker installation completed successfully"
show_warning "Please log out and log back in for docker group membership to take effect"