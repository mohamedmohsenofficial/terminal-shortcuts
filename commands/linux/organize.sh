#!/bin/bash
cd "$(dirname "$0")"
for file in *; do
    if [ -f "$file" ] && [ "$file" != "$(basename "$0")" ]; then
        ext="${file##*.}"
        if [[ "$file" == *.* && "$ext" != "$file" ]]; then
            mkdir -p "$ext"
            mv "$file" "$ext/"
        fi
    fi
done
