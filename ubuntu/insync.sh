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

show_info "Installing Insync"
sudo apt install -y insync || { 
	show_error "Failed to install Insync"
	exit 1
}

show_success "Insync installation completed successfully"