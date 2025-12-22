#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

TOOLBOX_ARCHIVES=(~/Downloads/jetbrains-toolbox-*.tar.gz)
if [[ ${#TOOLBOX_ARCHIVES[@]} -eq 0 ]] || [[ ! -f "${TOOLBOX_ARCHIVES[1]}" ]]; then
	show_error "No JetBrains Toolbox archive file found matching pattern: ~/Downloads/jetbrains-toolbox-*.tar.gz."
	show_error "Download from https://www.jetbrains.com/toolbox-app/ and place it in the Downloads folder."
	exit 1
elif [[ ${#TOOLBOX_ARCHIVES[@]} -gt 1 ]]; then
	show_error "Multiple JetBrains Toolbox archive files found: ${TOOLBOX_ARCHIVES[*]}"
	exit 1
fi

TOOLBOX_ARCHIVE_PATH="${TOOLBOX_ARCHIVES[1]}"
show_info "Found JetBrains Toolbox archive: $TOOLBOX_ARCHIVE_PATH"

show_info "Creating /opt/jetbrains-toolbox directory"
sudo mkdir -p /opt/jetbrains-toolbox || { show_error "Failed to create /opt/jetbrains-toolbox directory"; exit 1; }

show_info "Extracting JetBrains Toolbox archive to /opt/jetbrains-toolbox"
sudo tar -xzf "$TOOLBOX_ARCHIVE_PATH" -C /opt/jetbrains-toolbox --strip-components=1 || { show_error "Failed to extract JetBrains Toolbox archive"; exit 1; }

show_info "Creating symbolic link for jetbrains-toolbox in /usr/local/bin"
sudo ln -s  /opt/jetbrains-toolbox/bin/jetbrains-toolbox /usr/local/bin/jetbrains-toolbox || { show_error "Failed to create symbolic link for jetbrains-toolbox"; exit 1; }

show_info "JetBrains Toolbox installation completed successfully."