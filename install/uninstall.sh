#!/usr/bin/env bash

set -e

echo "Removing Terminal Shortcuts..."

rm -f ~/.local/bin/*

rm -rf ~/.terminal-shortcuts

echo
echo "Terminal Shortcuts has been removed."
