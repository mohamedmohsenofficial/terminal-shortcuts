#!/usr/bin/env bash

set -e

echo "Installing Terminal Shortcuts..."

mkdir -p ~/.local/bin

chmod +x ../linux/*

ln -sf "$(pwd)/../linux/update" ~/.local/bin/update
ln -sf "$(pwd)/../linux/cleaner" ~/.local/bin/cleaner
ln -sf "$(pwd)/../linux/doctor" ~/.local/bin/doctor
ln -sf "$(pwd)/../linux/repair" ~/.local/bin/repair

echo ""
echo "Installation completed."
echo ""
echo "Make sure ~/.local/bin is in your PATH."
echo "Restart your terminal."
