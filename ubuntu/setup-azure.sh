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

# Check if Azure CLI is already installed
if command -v az &> /dev/null; then
	show_info "Azure CLI is already installed"
	$IS_TOP_LEVEL && exit 0 || return 0
fi

show_info "Installing Microsoft GPG key"
sudo mkdir -p /etc/apt/keyrings || { show_error "Failed to create keyrings directory"; exit 1; }

curl -sLS https://packages.microsoft.com/keys/microsoft.asc | \
	gpg --dearmor | \
	sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null || {
	show_error "Failed to download and install Microsoft GPG key"
	exit 1
}

sudo chmod go+r /etc/apt/keyrings/microsoft.gpg || { 
	show_error "Failed to set permissions on GPG key"
	exit 1
}

show_info "Adding Azure CLI repository to sources"
if ! sudo tee /etc/apt/sources.list.d/azure-cli.sources > /dev/null <<EOF; then
Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: noble
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg
EOF
	show_error "Failed to add Azure CLI repository"
	exit 1
fi

show_info "Updating package list"
sudo apt update || { show_error "Failed to update apt"; exit 1; }

show_info "Installing Azure CLI"
sudo apt install -y azure-cli || { 
	show_error "Failed to install Azure CLI"
	exit 1
}

show_success "Azure CLI installation completed successfully"