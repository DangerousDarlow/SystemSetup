#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

# Determine if script is being run at top level or sourced
# Must be done at script level, not inside a function
if [[ "$ZSH_EVAL_CONTEXT" == "toplevel" ]]; then
    IS_TOP_LEVEL=true
else
    IS_TOP_LEVEL=false
fi

ASDF_DIR="$HOME/.asdf"
ASDF_VERSION="0.18.0"
ASDF_ARCHIVE_URL="https://github.com/asdf-vm/asdf/releases/download/v${ASDF_VERSION}/asdf-v${ASDF_VERSION}-linux-amd64.tar.gz"
ASDF_ARCHIVE_CHECKSUM="sha256:4d3007070166cb0a652af26c3f0462b021e04cb26c4ab13894d13689da89f5b8"
ASDF_ARCHIVE_PATH="/tmp/asdf.tar.gz"

if [[ -d "$ASDF_DIR" ]]; then
	show_info "asdf is already installed at $ASDF_DIR"
	$IS_TOP_LEVEL && exit 0 || return 0
fi

show_info "Downloading asdf v${ASDF_VERSION}"
wget -O "$ASDF_ARCHIVE_PATH" "$ASDF_ARCHIVE_URL" || { 
	show_error "Failed to download asdf archive"
	exit 1
}

show_info "Verifying checksum"
verify_checksum "$ASDF_ARCHIVE_PATH" "$ASDF_ARCHIVE_CHECKSUM" || { 
	show_error "Checksum verification failed"
	exit 1
}

show_info "Creating directory $ASDF_DIR"
mkdir -p "$ASDF_DIR" || { 
	show_error "Failed to create directory $ASDF_DIR"
	exit 1
}

show_info "Extracting archive"
tar -xzf "$ASDF_ARCHIVE_PATH" -C "$ASDF_DIR" || { 
	show_error "Failed to extract asdf archive"
	rm -rf "$ASDF_DIR"
	exit 1
}

show_info "Cleaning up archive"
rm -f "$ASDF_ARCHIVE_PATH"

ZSH_RC="$HOME/.zshrc"
if ! grep -q 'export PATH="$HOME/.asdf' "$ZSH_RC" 2>/dev/null; then
	show_info "Adding asdf to $ZSH_RC"
	echo "" >> "$ZSH_RC"
	echo "# asdf version manager" >> "$ZSH_RC"
	echo "export PATH=${ASDF_DIR}:${ASDF_DIR}/shims:\$PATH" >> "$ZSH_RC"
	export PATH=${ASDF_DIR}:${ASDF_DIR}/shims:$PATH
fi

show_success "asdf installation completed successfully"