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

# Check if Insync is already installed
if command -v insync &> /dev/null; then
	show_info "Insync is already installed"
	$IS_TOP_LEVEL && exit 0 || return 0
fi

show_info "Installing Insync GPG key"
sudo mkdir -p /etc/apt/keyrings || { show_error "Failed to create keyrings directory"; exit 1; }

curl -sLS https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key | \
	gpg --dearmor | \
	sudo tee /etc/apt/keyrings/insync.gpg > /dev/null || {
	show_error "Failed to download and install Insync GPG key"
	exit 1
}

sudo chmod go+r /etc/apt/keyrings/insync.gpg || { 
	show_error "Failed to set permissions on GPG key"
	exit 1
}

show_info "Adding Insync repository to sources"
if ! sudo tee /etc/apt/sources.list.d/insync.sources > /dev/null <<EOF; then
Types: deb
URIs: https://apt.insync.io/ubuntu
Suites: $(lsb_release -cs)
Components: non-free contrib
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/insync.gpg
EOF
	show_error "Failed to add Insync repository"
	exit 1
fi

show_info "Updating package list"
sudo apt update || { show_error "Failed to update apt"; exit 1; }

show_info "Installing Insync"
sudo apt install -y insync || { 
	show_error "Failed to install Insync"
	exit 1
}

show_success "Insync installation completed successfully"