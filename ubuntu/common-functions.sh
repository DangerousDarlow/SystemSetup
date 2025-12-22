#!/bin/zsh

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

show_error() {
    echo -e "${RED}ERROR: $1${NC}"
}

show_success() {
    echo -e "${GREEN}$1${NC}"
}

show_info() {
    echo -e "${BLUE}$1${NC}"
}

show_warning() {
    echo -e "${YELLOW}WARNING: $1${NC}"
}

verify_checksum() {
    local file_path="$1"
    local expected_checksum="$2"
    
    if [ ! -f "$file_path" ]; then
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
    if [ "$actual_hash" = "$expected_hash" ]; then
        return 0 # success
    else
        show_error "Checksum mismatch for $file_path"
        show_error "Expected: $expected_hash"
        show_error "Actual:   $actual_hash"
        return 1 # failure
    fi
}