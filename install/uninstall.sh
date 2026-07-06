#!/usr/bin/env bash

set -euo pipefail

INSTALL_DIR="$HOME/.terminal-shortcuts"
BIN_DIR="$HOME/.local/bin"

echo "Removing Terminal Shortcuts..."
echo

# --------------------------------------------------
# Check installation
# --------------------------------------------------

if [ ! -d "$INSTALL_DIR" ]; then
    echo "Terminal Shortcuts is not installed."
    exit 0
fi

# --------------------------------------------------
# Remove symbolic links
# --------------------------------------------------

for PLATFORM in linux macos
do
    COMMANDS_DIR="$INSTALL_DIR/commands/$PLATFORM"

    if [ -d "$COMMANDS_DIR" ]; then

        find "$COMMANDS_DIR" -maxdepth 1 -type f | while read -r cmd
        do
            rm -f "$BIN_DIR/$(basename "$cmd")"
        done

    fi
done

# --------------------------------------------------
# Remove installation directory
# --------------------------------------------------

rm -rf "$INSTALL_DIR"

# --------------------------------------------------
# Finish
# --------------------------------------------------

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
echo "Terminal Shortcuts has been removed successfully."
echo
echo "Removed:"
echo
echo "• Installed commands"
echo "• Symbolic links"
echo "• Installation directory"
echo
echo "Command directory:"
echo "$BIN_DIR"
echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
