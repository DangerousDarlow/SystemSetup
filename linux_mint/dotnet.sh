#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Installing dotnet sdk"

sudo apt install dotnet-sdk-10.0 -y

show_success "dotnet sdk installed successfully"