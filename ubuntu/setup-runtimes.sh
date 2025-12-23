#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

# Verify asdf is available
if ! command -v asdf &> /dev/null; then
	show_error "asdf is not available. Please run setup-asdf.sh first"
	exit 1
fi

# Runtimes to install
declare -A RUNTIMES=(
	[nodejs]="Node.js"
	[dotnet]=".NET"
	[python]="Python"
)

for runtime plugin_name in ${(kv)RUNTIMES}; do
	show_info "Setting up $plugin_name"
	
	# Add plugin if not already added
	if ! asdf plugin list | grep -q "^${runtime}\$"; then
		show_info "Adding asdf plugin for $runtime"
		asdf plugin add "$runtime" || { 
			show_error "Failed to add asdf plugin for $runtime"
			exit 1
		}
	else
		show_info "Plugin for $runtime already added"
	fi
	
	show_info "Installing $plugin_name latest version"
	asdf install "$runtime" latest || { 
		show_error "Failed to install $runtime"
		exit 1
	}
	
	show_info "Setting global $runtime version"
	asdf set -u "$runtime" latest || { 
		show_error "Failed to set global $runtime version"
		exit 1
	}
	
	show_success "$plugin_name installed successfully"
	echo ""
done

show_success "All runtimes installed successfully"