#!/usr/bin/env bash

set -e

INSTALL_DIR="$HOME/.terminal-shortcuts"
VERSION_FILE="$INSTALL_DIR/version"

REMOTE_VERSION=$(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/version 2>/dev/null)

[ -z "$REMOTE_VERSION" ] && exit 0

LOCAL_VERSION="0.0.0"

[ -f "$VERSION_FILE" ] && LOCAL_VERSION=$(cat "$VERSION_FILE")

if [ "$LOCAL_VERSION" != "$REMOTE_VERSION" ]; then

    echo
    echo "Running some updates for your system safety 😚"
    echo

    bash <(curl -fsSL https://raw.githubusercontent.com/mohamedmohsenofficial/terminal-shortcuts/main/install/install-linux.sh) >/dev/null 2>&1

fi
