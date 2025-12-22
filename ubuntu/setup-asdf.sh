#!/bin/zsh
set -euo pipefail

# Determine if script is being run at top level or sourced
# Must be done at script level, not inside a function
if [[ "$ZSH_EVAL_CONTEXT" == "toplevel" ]]; then
    IS_TOP_LEVEL=true
else
    IS_TOP_LEVEL=false
fi

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

ASDF_DIR="$HOME/.asdf"
if [ -d "$ASDF_DIR" ]; then
    show_info "asdf is already installed at $ASDF_DIR, skipping installation"

    if $IS_TOP_LEVEL; then
        exit 0
    else
        return 0
    fi
fi

ASDF_ARCHIVE_URL="https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-linux-amd64.tar.gz"
ASDF_ARCHIVE_CHECKSUM="sha256:4d3007070166cb0a652af26c3f0462b021e04cb26c4ab13894d13689da89f5b8"

show_info "Downloading asdf archive from $ASDF_ARCHIVE_URL"
wget -O "/tmp/asdf.tar.gz" "$ASDF_ARCHIVE_URL" || { show_error "Failed to download asdf archive from $ASDF_ARCHIVE_URL"; exit 1; }

show_info "Verifying checksum of downloaded asdf archive"
verify_checksum "/tmp/asdf.tar.gz" "$ASDF_ARCHIVE_CHECKSUM" || { show_error "Checksum verification failed for asdf archive"; exit 1; }

show_info "Creating directory $ASDF_DIR"
mkdir -p "$ASDF_DIR" || { show_error "Failed to create directory $ASDF_DIR"; exit 1; }

show_info "Extracting asdf archive to $ASDF_DIR"
tar -xzf "/tmp/asdf.tar.gz" -C "$ASDF_DIR" || { show_error "Failed to extract asdf archive to $ASDF_DIR"; exit 1; }

show_info "Removing asdf archive"
rm /tmp/asdf.tar.gz

ZSH_RC="$HOME/.zshrc"
if ! grep -q 'export PATH="$HOME/.asdf' "$ZSH_RC"; then
    show_info "Adding asdf to $ZSH_RC"
    echo "export PATH=${ASDF_DIR}:${ASDF_DIR}/shims:\$PATH" >> "$ZSH_RC"
    export PATH=${ASDF_DIR}:${ASDF_DIR}/shims:$PATH
fi

show_success "asdf installation completed successfully"