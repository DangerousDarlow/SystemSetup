#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

TOOLBOX_PATTERN="$HOME/Downloads/jetbrains-toolbox-*.tar.gz"
TOOLBOX_ARCHIVES=($~TOOLBOX_PATTERN)

if [[ ${#TOOLBOX_ARCHIVES[@]} -eq 0 ]] || [[ ! -f "${TOOLBOX_ARCHIVES[1]}" ]]; then
	show_error "No JetBrains Toolbox archive file found matching pattern: ~/Downloads/jetbrains-toolbox-*.tar.gz."
	show_error "Download from https://www.jetbrains.com/toolbox-app/ and place it in the Downloads folder."
	exit 1
elif [[ ${#TOOLBOX_ARCHIVES[@]} -gt 1 ]]; then
	show_error "Multiple JetBrains Toolbox archive files found: ${TOOLBOX_ARCHIVES[*]}"
	exit 1
fi

TOOLBOX_ARCHIVE_PATH="${TOOLBOX_ARCHIVES[1]}"
show_info "Found JetBrains Toolbox archive: $(basename "$TOOLBOX_ARCHIVE_PATH")"

INSTALL_DIR="/opt/jetbrains-toolbox"
BIN_LINK="/usr/local/bin/jetbrains-toolbox"

# Check if already installed
if [[ -L "$BIN_LINK" ]] && [[ -x "$BIN_LINK" ]]; then
	show_error "JetBrains Toolbox is already installed at $BIN_LINK"
	exit 1
fi

show_info "Creating installation directory"
sudo mkdir -p "$INSTALL_DIR" || { show_error "Failed to create $INSTALL_DIR"; exit 1; }

show_info "Extracting archive"
sudo tar -xzf "$TOOLBOX_ARCHIVE_PATH" -C "$INSTALL_DIR" --strip-components=1 || { 
	show_error "Failed to extract archive"
	sudo rm -rf "$INSTALL_DIR"
	exit 1
}

show_info "Creating symbolic link"
sudo ln -sf "$INSTALL_DIR/jetbrains-toolbox" "$BIN_LINK" || { 
	show_error "Failed to create symbolic link"
	exit 1
}

show_success "JetBrains Toolbox installation completed successfully"