#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

APPLICATIONS=(
	"md.obsidian.Obsidian"
)

for package in "${APPLICATIONS[@]}"; do
	show_info "Installing application: $package"

	flatpak install -y ${=package} || {
		show_error "Failed to install application: $package"
		exit 1
	}

	show_success "Application installed: $package"
done

show_success "All Snap packages installed successfully"