#!/bin/zsh
set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"

source "$SCRIPT_DIR/common-functions.sh"
source "$SCRIPT_DIR/setup-apt.sh"
source "$SCRIPT_DIR/setup-github.sh"
source "$SCRIPT_DIR/setup-asdf.sh"
source "$SCRIPT_DIR/setup-runtimes.sh"
source "$SCRIPT_DIR/setup-docker.sh"

show_success "Setup completed successfully"