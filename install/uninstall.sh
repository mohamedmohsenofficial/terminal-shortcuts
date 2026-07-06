#!/usr/bin/env bash

set -e

INSTALL_DIR="$HOME/.terminal-shortcuts"
BIN_DIR="$HOME/.local/bin"

echo "Removing Terminal Shortcuts..."

if [ -d "$INSTALL_DIR/commands/linux" ]; then
    for cmd in "$INSTALL_DIR/commands/linux"/*; do
        [ -f "$cmd" ] || continue
        rm -f "$BIN_DIR/$(basename "$cmd")"
    done
fi

if [ -d "$INSTALL_DIR/commands/macos" ]; then
    for cmd in "$INSTALL_DIR/commands/macos"/*; do
        [ -f "$cmd" ] || continue
        rm -f "$BIN_DIR/$(basename "$cmd")"
    done
fi

rm -rf "$INSTALL_DIR"

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
echo "Terminal Shortcuts has been removed."
echo
echo "Removed:"
echo
echo "• Installed commands"
echo "• Symbolic links"
echo "• Installation directory"
echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
