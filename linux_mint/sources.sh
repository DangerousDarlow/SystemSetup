#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Adding sources"

show_info "Adding Microsoft Ubuntu packages source"

ms_deb_path="/tmp/packages-microsoft-prod.deb"
if ! wget -q -O "$ms_deb_path" https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb; then
	show_error "Failed to download Microsoft Ubuntu packages source"
	exit 1
fi

if ! sudo dpkg -i "$ms_deb_path"; then
	show_error "Failed to install Microsoft Ubuntu packages source"
	exit 1
fi

rm -f "$ms_deb_path"

show_info "Adding github cli source"
if ! sudo tee /etc/apt/sources.list.d/github-cli.sources > /dev/null <<EOF; then
Types: deb
URIs: https://cli.github.com/packages
Suites: stable
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/github-cli.gpg
EOF
	show_error "Failed to add Insync source"
	exit 1
fi

show_info "Adding docker source"
if ! sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF; then
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.gpg
EOF
	show_error "Failed to add docker source"
	exit 1
fi

show_info "Adding Azure CLI source"
if ! sudo tee /etc/apt/sources.list.d/azure-cli.sources > /dev/null <<EOF; then
Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg
EOF
	show_error "Failed to add Azure CLI source"
	exit 1
fi

show_info "Adding Insync source"
if ! sudo tee /etc/apt/sources.list.d/insync.sources > /dev/null <<EOF; then
Types: deb
URIs: https://apt.insync.io/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: non-free contrib
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/insync.gpg
EOF
	show_error "Failed to add Insync source"
	exit 1
fi

sudo apt update

show_success "Sources added successfully"
