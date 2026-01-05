#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

SNAP_PACKAGES=(
	"obsidian --classic"
)

for package in "${SNAP_PACKAGES[@]}"; do
	show_info "Installing Snap package: $package"

	if ! snap list | grep -q "^${package%% *}\$"; then

		sudo snap install ${=package} || {
			show_error "Failed to install Snap package: $package"
			exit 1
		}
		show_success "Snap package installed: $package"
	else
		show_info "Snap package already installed: $package"
	fi
done

show_success "All Snap packages installed successfully"