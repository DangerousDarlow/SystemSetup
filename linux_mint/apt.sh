#!/bin/zsh
set -euo pipefail

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/common-functions.sh"

show_info "Updating apt"
sudo apt update -y || { show_error "Failed to update apt"; exit 1; }

show_info "Upgrading apt packages"
sudo apt full-upgrade -y || { show_error "Failed to upgrade apt packages"; exit 1; }

show_info "Removing unnecessary apt packages"
sudo apt autoremove -y || { show_error "Failed to remove unnecessary apt packages"; exit 1; }

show_info "Installing common apt packages"
sudo apt install -y \
  aptitude \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  git \
  gnupg \
  jq \
  lsb-release \
  ripgrep \
  unzip \
  vim \
  wget \
  zip \
  zsh || { show_error "Failed to install common apt packages"; exit 1; }

show_info "Installing Python development packages"
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
  zlib1g-dev || { show_error "Failed to install Python development packages"; exit 1; }

show_success "apt setup completed successfully"