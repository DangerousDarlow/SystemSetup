#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Setting up Corepack"

# Check if corepack is available
if ! command -v corepack &> /dev/null; then
    show_info "Corepack not found. Installing with npm..."
    npm install -g corepack
    
    show_info "Reshimming asdf..."
    asdf reshim nodejs
    
    show_info "Enabling corepack..."
    corepack enable
else
    show_info "Corepack already available"
fi

# Activate the latest pnpm
show_info "Activating latest pnpm..."
corepack prepare pnpm@latest --activate

show_success "Corepack setup complete"