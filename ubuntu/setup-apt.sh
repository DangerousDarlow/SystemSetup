#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Updating apt repositories"
sudo apt update -y || { show_error "Failed to update apt repositories"; exit 1; }

show_info "Upgrading installed packages"
sudo apt full-upgrade -y || { show_error "Failed to upgrade installed packages"; exit 1; }

show_info "Removing unnecessary packages"
sudo apt autoremove -y || { show_error "Failed to remove unnecessary packages"; exit 1; }

show_info "Installing common utilities"
sudo apt install -y curl git vim wget zip unzip zsh || { show_error "Failed to install common utilities"; exit 1; }

show_info "Installing development tools and libraries"
sudo apt install -y \
  apt-transport-https \
  build-essential \
  ca-certificates \
  gnupg \
  lsb-release || { show_error "Failed to install development tools"; exit 1; }

show_info "Installing Python development libraries"
sudo apt install -y \
  libbz2-dev \
  libffi-dev \
  liblzma-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  tk-dev \
  uuid-dev \
  xz-utils \
  zlib1g-dev || { show_error "Failed to install Python development libraries"; exit 1; }

show_success "apt setup completed successfully"