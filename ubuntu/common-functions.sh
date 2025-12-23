#!/bin/zsh

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

show_error() {
	[[ -z "$1" ]] && return 1
	echo -e "${RED}ERROR: $1${NC}" >&2
}

show_success() {
	[[ -z "$1" ]] && return 1
	echo -e "${GREEN}SUCCESS: $1${NC}"
}

show_info() {
	[[ -z "$1" ]] && return 1
	echo -e "${BLUE}INFO: $1${NC}"
}

show_warning() {
	[[ -z "$1" ]] && return 1
	echo -e "${YELLOW}WARNING: $1${NC}" >&2
}

verify_checksum() {
	local file_path="$1"
	local expected_checksum="$2"
	
	if [[ -z "$file_path" ]] || [[ -z "$expected_checksum" ]]; then
		show_error "verify_checksum requires two arguments: file_path and expected_checksum"
		return 1
	fi
	
	if [[ ! -f "$file_path" ]]; then
		show_error "File not found for checksum verification: $file_path"
		return 1
	fi
	
	if [[ ! "$expected_checksum" =~ ^sha256: ]]; then
		show_error "Checksum must start with 'sha256:'"
		return 1
	fi
	
	# Extract the hash value (remove sha256: prefix)
	local expected_hash="${expected_checksum#sha256:}"
	
	# Get actual file checksum
	local actual_hash=$(sha256sum "$file_path" | awk '{print $1}')
	
	# Verify checksums match
	if [[ "$actual_hash" == "$expected_hash" ]]; then
		show_info "Checksum verified for $(basename "$file_path")"
		return 0 # success
	else
		show_error "Checksum mismatch for $file_path"
		show_error "Expected: $expected_hash"
		show_error "Actual:   $actual_hash"
		return 1 # failure
	fi
}