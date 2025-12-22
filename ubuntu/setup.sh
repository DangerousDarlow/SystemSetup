#!/bin/zsh
set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"

source "$SCRIPT_DIR/common-functions.sh"
source "$SCRIPT_DIR/setup-apt.sh"
source "$SCRIPT_DIR/setup-github.sh"
source "$SCRIPT_DIR/setup-asdf.sh"

show_success "Setup completed successfully"