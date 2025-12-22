#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Adding Microsoft gpg key"

sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

show_info "Adding Azure CLI repository to sources list"

sudo tee /etc/apt/sources.list.d/azure-cli.sources <<EOF
Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: noble
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg
EOF

sudo apt update

show_info "Installing Azure CLI"
sudo apt install -y azure-cli || { show_error "Failed to install Azure CLI"; exit 1; }

show_success "Azure CLI installation completed successfully"