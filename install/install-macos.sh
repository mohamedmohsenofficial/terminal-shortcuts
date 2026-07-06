#!/usr/bin/env bash

set -e

echo "Installing Terminal Shortcuts..."

mkdir -p ~/.local/bin

chmod +x ../macos/*

ln -sf "$(pwd)/../macos/update" ~/.local/bin/update
ln -sf "$(pwd)/../macos/cleaner" ~/.local/bin/cleaner
ln -sf "$(pwd)/../macos/doctor" ~/.local/bin/doctor
ln -sf "$(pwd)/../macos/repair" ~/.local/bin/repair

echo ""
echo "Installation completed."
echo ""
echo "Restart your terminal."
