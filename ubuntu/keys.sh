#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Installing keys"

KEYRING_DIR="/etc/apt/keyrings"

show_info "Creating keyrings directory"
sudo mkdir -p "$KEYRING_DIR" || { show_error "Failed to create keyrings directory"; exit 1; }

install_key() {
    local key_url="$1"
    local key_filename="$2"
    local dearmor="${3:-true}"
    local key_path="$KEYRING_DIR/$key_filename"

    if [[ "$dearmor" != "true" && "$dearmor" != "false" ]]; then
        show_error "Invalid dearmor flag (expected true/false): $dearmor"
        exit 1
    fi

    if [[ -z "$key_filename" || "$key_filename" == */* || "$key_filename" == *".."* ]]; then
        show_error "Invalid key filename: $key_filename"
        exit 1
    fi

    show_info "Installing key $key_filename from $key_url"

    sudo rm -f "$key_path" || {
        show_error "Failed to remove existing key file: $key_filename"
        exit 1
    }

    if [[ "$dearmor" == "true" ]]; then
        curl -fsSL "$key_url" | \
            sudo gpg --batch --yes --dearmor -o "$key_path" || {
                show_error "Failed to download, dearmor and install key: $key_filename"
                exit 1
        }
    else
        curl -fsSL "$key_url" | sudo tee "$key_path" >/dev/null || {
            show_error "Failed to download and install key: $key_filename"
            exit 1
        }
    fi

    sudo chmod 644 "$key_path" || {
        show_error "Failed to set permissions on key: $key_filename"
        exit 1
    }
}

KEYS=(
        "https://packages.microsoft.com/keys/microsoft.asc microsoft.gpg"
        "https://download.docker.com/linux/ubuntu/gpg docker.gpg"
        "https://apt.insync.io/insynchq.gpg insync.gpg"
        "https://cli.github.com/packages/githubcli-archive-keyring.gpg github-cli.gpg false"
)

for key in "${KEYS[@]}"; do
    IFS=' ' read -r key_url key_filename key_dearmor <<< "$key"
    install_key "$key_url" "$key_filename" "${key_dearmor:-true}"
done

show_success "Keys installation completed successfully"