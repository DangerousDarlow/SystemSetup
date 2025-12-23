#!/bin/zsh
set -euo pipefail

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"

# Source common functions first
source "$SCRIPT_DIR/common-functions.sh"

# Setup scripts to run
SETUP_SCRIPTS=(
	"setup-apt.sh"
	"setup-github.sh"
	"setup-asdf.sh"
	"setup-runtimes.sh"
	"setup-docker.sh"
	"setup-azure.sh"
)

for script in "${SETUP_SCRIPTS[@]}"; do
	script_path="$SCRIPT_DIR/$script"
	if [[ ! -f "$script_path" ]]; then
		show_error "Setup script not found: $script"
		exit 1
	fi
	
	show_info "Running $script..."
	source "$script_path" || {
		show_error "Failed to run $script"
		exit 1
	}
	echo ""
done

show_success "All setup scripts completed successfully"