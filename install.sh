#!/usr/bin/env bash

set -Eeuo pipefail

echo "Installing SysGuard..."

# Check Bash
if ! command -v bash >/dev/null 2>&1; then
    echo "Error: Bash is not installed."
    exit 1
fi

# Create required directories
mkdir -p logs
mkdir -p reports

# Make executable
chmod +x sysguard.sh

# Install globally
sudo ln -sf "$(pwd)/sysguard.sh" /usr/local/bin/sysguard

echo
echo "Installation completed successfully."
echo
echo "You can now run:"
echo "    sysguard"
echo "    sysguard --report"
echo "    sysguard --json"
echo "    sysguard --csv"