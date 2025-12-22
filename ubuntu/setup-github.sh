#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

if ! which gh >/dev/null 2>&1; then
	show_info "Installing GitHub CLI"
	
    # Copied from https://github.com/cli/cli/blob/trunk/docs/install_linux.md
	(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
		&& sudo mkdir -p -m 755 /etc/apt/keyrings \
		&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
		&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
		&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
		&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
		&& sudo apt update \
		&& sudo apt install gh -y || { show_error "Failed to install GitHub CLI"; exit 1; }
else
	show_info "GitHub CLI is already installed"
fi

git config --global user.name "Nick Darlow"
git config --global user.email "dangerous.darlow@gmail.com" 
git config --global core.autocrlf input

show_success "GitHub CLI installation completed successfully"