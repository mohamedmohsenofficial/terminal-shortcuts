#!/usr/bin/env bash

set -e

REPO="https://github.com/mohamedmohsenofficial/terminal-shortcuts.git"
INSTALL_DIR="$HOME/.terminal-shortcuts"
BIN_DIR="$HOME/.local/bin"

echo "Installing Terminal Shortcuts..."

if ! command -v git >/dev/null 2>&1; then
    echo "Git is required."
    exit 1
fi

rm -rf "$INSTALL_DIR"

git clone "$REPO" "$INSTALL_DIR"

mkdir -p "$BIN_DIR"

chmod +x "$INSTALL_DIR/linux/"*

for cmd in "$INSTALL_DIR/linux/"*; do
    ln -sf "$cmd" "$BIN_DIR/$(basename "$cmd")"
done

if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then

    if [ -f "$HOME/.bashrc" ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi

    if [ -f "$HOME/.zshrc" ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    fi

fi

echo
echo "Installation completed!"
echo
echo "Restart your terminal."
echo
echo "Now you can run:"
echo
echo "update"
echo "cleaner"
echo "doctor"
echo "repair"
