#!/usr/bin/env bash
# Setup script for NixOS proxy configuration
# This script helps securely configure proxy credentials

set -euo pipefail

PROXY_HOST="pl21.speedycdn.space"
PROXY_PORT="13540"
CREDENTIALS_FILE="/etc/proxy-credentials"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}=== NixOS Proxy Configuration Setup ===${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_error "This script must be run as root (use sudo)"
        exit 1
    fi
}

setup_credentials() {
    print_header

    print_info "Proxy Details:"
    echo "  Host: $PROXY_HOST"
    echo "  Port: $PROXY_PORT"
    echo ""

    read -p "Enter proxy username: " username
    read -sp "Enter proxy password: " password
    echo ""

    if [[ -z "$username" || -z "$password" ]]; then
        print_error "Username and password cannot be empty"
        exit 1
    fi

    # Create the credentials file
    echo "${username}:${password}" | sudo tee "$CREDENTIALS_FILE" > /dev/null

    # Set proper permissions (600 = read/write for owner only)
    sudo chmod 600 "$CREDENTIALS_FILE"

    print_success "Credentials file created at $CREDENTIALS_FILE"
    print_success "Permissions set to 600 (owner read/write only)"
    echo ""
}

setup_shell_integration() {
    print_info "Setting up shell integration..."

    local shell_config=""

    if [[ -f "$HOME/.bashrc" ]]; then
        shell_config="$HOME/.bashrc"
    elif [[ -f "$HOME/.zshrc" ]]; then
        shell_config="$HOME/.zshrc"
    else
        print_warning "Could not find shell configuration file"
        return
    fi

    # Check if proxy setup already exists
    if grep -q "# Proxy configuration" "$shell_config"; then
        print_warning "Proxy configuration already exists in $shell_config"
        return
    fi

    # Add proxy configuration to shell config
    cat >> "$shell_config" << 'EOF'

# Proxy configuration
if [ -f /etc/proxy-credentials ]; then
    CREDS=$(cat /etc/proxy-credentials)
    export http_proxy="http://${CREDS}@pl21.speedycdn.space:13540"
    export https_proxy="http://${CREDS}@pl21.speedycdn.space:13540"
    export HTTP_PROXY="http://${CREDS}@pl21.speedycdn.space:13540"
    export HTTPS_PROXY="http://${CREDS}@pl21.speedycdn.space:13540"
    export NO_PROXY="127.0.0.1,localhost,127.0.0.0/8,::1,0.0.0.0"
fi
EOF

    print_success "Shell integration added to $shell_config"
    echo ""
}

test_proxy() {
    print_info "Testing proxy configuration..."
    echo ""

    if ! command -v curl &> /dev/null; then
        print_warning "curl not found, skipping proxy test"
        return
    fi

    # Reload credentials
    if [ -f /etc/proxy-credentials ]; then
        CREDS=$(cat /etc/proxy-credentials)
        export http_proxy="http://${CREDS}@pl21.speedycdn.space:13540"
        export https_proxy="http://${CREDS}@pl21.speedycdn.space:13540"
    fi

    if curl -s --max-time 5 "https://www.google.com" > /dev/null 2>&1; then
        print_success "Proxy connection test passed!"
    else
        print_warning "Proxy connection test failed"
        echo "Please verify:"
        echo "  1. Credentials are correct"
        echo "  2. Proxy server is online"
        echo "  3. Network connectivity is available"
    fi
    echo ""
}

print_next_steps() {
    echo -e "${BLUE}=== Next Steps ===${NC}"
    echo ""
    echo "1. Source your shell configuration:"
    echo "   source ~/.bashrc  # or ~/.zshrc"
    echo ""
    echo "2. Test the proxy:"
    echo "   curl -v https://www.google.com"
    echo ""
    echo "3. For other applications, configure separately:"
    echo "   - Git:   git config --global http.proxy http://user:pass@pl21.speedycdn.space:13540"
    echo "   - npm:   npm config set proxy http://user:pass@pl21.speedycdn.space:13540"
    echo "   - pip:   pip config set global.proxy [user:pass@]proxy.server:port"
    echo ""
    echo "For more information, see /etc/nixos/nixos/proxy/SETUP.md"
    echo ""
}

main() {
    check_root
    setup_credentials
    setup_shell_integration
    test_proxy
    print_next_steps
    print_success "Setup complete!"
}

main "$@"
