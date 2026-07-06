#!/usr/bin/env bash

set -e

REPO="https://github.com/mohamedmohsenofficial/terminal-shortcuts.git"
INSTALL_DIR="$HOME/.terminal-shortcuts"
BIN_DIR="$HOME/.local/bin"
COMMANDS_DIR="$INSTALL_DIR/commands/linux"

echo " Installing Terminal Shortcuts..."

# Check Git
if ! command -v git >/dev/null 2>&1; then
    echo "❌ Git is required but is not installed."
    exit 1
fi

# Remove previous installation
rm -rf "$INSTALL_DIR"

# Clone repository
git clone "$REPO" "$INSTALL_DIR"

# Create bin directory
mkdir -p "$BIN_DIR"

# Make all commands executable
find "$COMMANDS_DIR" -type f -exec chmod +x {} \;

# Create symbolic links
for cmd in "$COMMANDS_DIR"/*; do
    [ -f "$cmd" ] || continue
    ln -sf "$cmd" "$BIN_DIR/$(basename "$cmd")"
done

# Add ~/.local/bin to PATH if needed
SHELL_CONFIG=""

if [ -n "$BASH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

if [ -n "$SHELL_CONFIG" ]; then
    if ! grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_CONFIG" 2>/dev/null; then
        echo '' >> "$SHELL_CONFIG"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
    fi
fi

echo
echo " Terminal Shortcuts installed successfully!"
echo
echo "Installed commands:"
echo

for cmd in "$COMMANDS_DIR"/*; do
    [ -f "$cmd" ] || continue
    echo "• $(basename "$cmd")"
done

echo
echo "Restart your terminal or run:"
echo
echo "source $SHELL_CONFIG"
