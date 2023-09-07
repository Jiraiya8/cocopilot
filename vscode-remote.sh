#!/bin/bash

set -e

EXTENSIONS_DIR="$HOME/.vscode-server/extensions"
if [ ! -d "$EXTENSIONS_DIR" ]; then
  echo "ERROR: VSCode extensions directory not found!"
  exit 1
fi

COPILOT_DIR=$(ls -lt "$EXTENSIONS_DIR" | grep '^d' | awk '{print $9}' | grep -E '^github\.copilot-[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1)
if [ -z "$COPILOT_DIR" ]; then
  echo "ERROR: Copilot extension not found!"
  exit 1
fi

COPILOT_DIR="$EXTENSIONS_DIR/$COPILOT_DIR"
EXTENSION_FILE="$COPILOT_DIR/dist/extension.js"
if [ ! -f "$EXTENSION_FILE" ]; then
  echo "ERROR: Copilot extension entry file not found!"
  exit 1
fi

TMP_FILE="$COPILOT_DIR/dist/extension.js.tmp"
echo 'process.env.CODESPACES="true";process.env.GITHUB_TOKEN="ghu_ThisIsARealFreeCopilotKeyByCoCopilot";process.env.GITHUB_SERVER_URL="https://github.com";process.env.GITHUB_API_URL="https://api.cocopilot.org";' > "$TMP_FILE"
cat "$EXTENSION_FILE" >> "$TMP_FILE"
mv "$TMP_FILE" "$EXTENSION_FILE"

echo 'done. please restart your vscode.'
