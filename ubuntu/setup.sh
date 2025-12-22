#!/bin/zsh
set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"

source "$SCRIPT_DIR/setup-asdf.sh"

show_success "Setup completed successfully"