#!/usr/bin/env bash

SRC_BASE=~/android-kernel/out/android12-5.10/dist
DEST_DIR=.
LOG_FILE=missing_modules.log

# clear previous log
: > "$LOG_FILE"

shopt -s nullglob

for dest_file in "$DEST_DIR"/*.ko; do
    name=$(basename "$dest_file")

    # find matching module in source tree
    src_file=$(find "$SRC_BASE" -type f -name "$name" 2>/dev/null | head -n 1)

    if [[ -n "$src_file" ]]; then
        cp "$src_file" "$DEST_DIR/$name"
        echo "[OK] $name <- $src_file"
    else
        echo "[MISSING] $name" | tee -a "$LOG_FILE"
    fi
done

echo
echo "done. missing modules (if any) logged to $LOG_FILE"
