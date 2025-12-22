#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Adding adsf plugin for nodejs"
asdf plugin add nodejs || { show_error "Failed to add asdf plugin for nodejs"; exit 1; }

show_info "Installing nodejs"
asdf install nodejs latest || { show_error "Failed to install nodejs"; exit 1; }

show_info "Setting global nodejs version"
asdf set -u nodejs latest || { show_error "Failed to set global nodejs version"; exit 1; }

show_info "Adding asdf plugin for dotnet"
asdf plugin add dotnet || { show_error "Failed to add asdf plugin for dotnet"; exit 1; }

show_info "Installing dotnet"
asdf install dotnet latest || { show_error "Failed to install dotnet"; exit 1; }

show_info "Setting global dotnet version"
asdf set -u dotnet latest || { show_error "Failed to set global dotnet version"; exit 1; }

show_info "Adding asdf plugin for python"
asdf plugin add python || { show_error "Failed to add asdf plugin for python"; exit 1; }

show_info "Installing python"
asdf install python latest || { show_error "Failed to install python"; exit 1; }

show_info "Setting global python version"
asdf set -u python latest || { show_error "Failed to set global python version"; exit 1; }

show_success "Runtimes setup completed successfully"