#!/usr/bin/env bash

set -euo pipefail

REPO="https://github.com/mohamedmohsenofficial/terminal-shortcuts.git"
INSTALL_DIR="$HOME/.terminal-shortcuts"
COMMANDS_DIR="$INSTALL_DIR/commands/linux"
BIN_DIR="$HOME/.local/bin"

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
# Create ~/.local/bin
# --------------------------------------------------

mkdir -p "$BIN_DIR"

# --------------------------------------------------
# Make commands executable
# --------------------------------------------------

find "$COMMANDS_DIR" -type f -exec chmod +x {} \;

# --------------------------------------------------
# Create symbolic links
# --------------------------------------------------

find "$COMMANDS_DIR" -maxdepth 1 -type f | while read -r cmd
do
    ln -sf "$cmd" "$BIN_DIR/$(basename "$cmd")"
done

# --------------------------------------------------
# Detect shell configuration
# --------------------------------------------------

SHELL_CONFIG=""

if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

# --------------------------------------------------
# Add ~/.local/bin to PATH
# --------------------------------------------------

if [ -n "$SHELL_CONFIG" ]; then

    if ! grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_CONFIG" 2>/dev/null; then

        {
            echo
            echo '# Terminal Shortcuts'
            echo 'export PATH="$HOME/.local/bin:$PATH"'
        } >> "$SHELL_CONFIG"

    fi

fi

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

if [ -n "$SHELL_CONFIG" ]; then
    echo "Restart your terminal or run:"
    echo
    echo "source $SHELL_CONFIG"
else
    echo "Restart your terminal."
fi

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
