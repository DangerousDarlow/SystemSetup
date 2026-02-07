#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Installing node version manager (nvm)"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
source ~/.zshrc

show_info "Installing node lts"
nvm install --lts

show_info "Enabling core pack"
corepack enable

show_info "Installing pnpm"
corepack prepare pnpm@latest --activate

show_success "Node installed successfully"