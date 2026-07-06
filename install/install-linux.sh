#!/usr/bin/env bash

set -e

REPO="https://github.com/mohamedmohsenofficial/terminal-shortcuts.git"
INSTALL_DIR="$HOME/.terminal-shortcuts"
BIN_DIR="$HOME/.local/bin"
COMMANDS_DIR="$INSTALL_DIR/commands/linux"

echo "Installing Terminal Shortcuts..."

if ! command -v git >/dev/null 2>&1; then
    echo "Error: Git is required but is not installed."
    exit 1
fi

rm -rf "$INSTALL_DIR"

git clone --quiet "$REPO" "$INSTALL_DIR"

mkdir -p "$BIN_DIR"

find "$COMMANDS_DIR" -type f -exec chmod +x {} \;

for cmd in "$COMMANDS_DIR"/*; do
    [ -f "$cmd" ] || continue
    ln -sf "$cmd" "$BIN_DIR/$(basename "$cmd")"
done

SHELL_CONFIG=""

if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

if [ -n "$SHELL_CONFIG" ]; then
    if ! grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_CONFIG"; then
        {
            echo
            echo 'export PATH="$HOME/.local/bin:$PATH"'
        } >> "$SHELL_CONFIG"
    fi
fi

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
echo "Terminal Shortcuts installed successfully."
echo
echo "Installed commands:"
echo

for cmd in "$COMMANDS_DIR"/*; do
    [ -f "$cmd" ] || continue
    echo "• $(basename "$cmd")"
done

echo
echo "Installation directory:"
echo "$INSTALL_DIR"
echo
echo "Command directory:"
echo "$BIN_DIR"
echo
echo "Restart your terminal or run:"
echo
echo "source $SHELL_CONFIG"
echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
