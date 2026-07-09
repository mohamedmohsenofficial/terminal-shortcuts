#!/usr/bin/env bash

set -euo pipefail

REPO="https://github.com/mohamedmohsenofficial/terminal-shortcuts.git"
INSTALL_DIR="$HOME/.terminal-shortcuts"
COMMANDS_DIR="$INSTALL_DIR/commands/linux"
BIN_DIR="/usr/local/bin"

echo "Installing Terminal Shortcuts..."
echo

# --------------------------------------------------
# Check requirements
# --------------------------------------------------

if ! command -v git >/dev/null 2>&1; then
    echo "Error: Git is not installed."
    echo "Please install Git and try again."
    exit 1
fi

# --------------------------------------------------
# Request sudo
# --------------------------------------------------

echo "Administrator privileges are required."
sudo -v

# --------------------------------------------------
# Remove previous installation
# --------------------------------------------------

rm -rf "$INSTALL_DIR"

# --------------------------------------------------
# Clone repository
# --------------------------------------------------

git clone --quiet --depth 1 "$REPO" "$INSTALL_DIR"

# --------------------------------------------------
# Verify installation
# --------------------------------------------------

if [ ! -d "$COMMANDS_DIR" ]; then
    echo "Error: Command directory not found."
    exit 1
fi

# --------------------------------------------------
# Install commands
# --------------------------------------------------

find "$COMMANDS_DIR" -maxdepth 1 -type f | while read -r cmd
do
    sudo install -m755 "$cmd" "$BIN_DIR/$(basename "$cmd")"
done

sudo install -m755 \
"$INSTALL_DIR/install/update-terminal-shortcuts.sh" \
"$BIN_DIR/update-terminal-shortcuts"

# --------------------------------------------------
# Finish
# --------------------------------------------------

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
echo "Terminal Shortcuts installed successfully."
echo
echo "Installed commands:"
echo

find "$COMMANDS_DIR" -maxdepth 1 -type f \
| sort \
| while read -r cmd
do
    echo "• $(basename "$cmd")"
done

echo
echo "Installation directory:"
echo "$INSTALL_DIR"

echo
echo "Command directory:"
echo "$BIN_DIR"

echo
echo "You can now use the commands from any terminal."

echo
echo "Examples:"
echo
echo "update"
echo "sudo update"
echo "repair"
echo "sudo repair"
echo "check_os"
echo "sudo check_os"

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
