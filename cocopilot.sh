#!/bin/bash

set -e

if [ -n "$XDG_CONFIG_HOME" ]; then
  CONFIG_DIR="$XDG_CONFIG_HOME"
else
  CONFIG_DIR="$HOME/.config"
fi

COPILOT_DIR="$CONFIG_DIR/github-copilot"
if [ ! -d "$COPILOT_DIR" ]; then
  mkdir -p "$COPILOT_DIR}"
fi

echo '{"github.com":{"user":"cocopilot","oauth_token":"ghu_ThisIsARealFreeCopilotKeyByCoCopilot","dev_override":{"copilot_token_url":"https://api.cocopilot.org/copilot_internal/v2/token"}}}' > "$COPILOT_DIR/hosts.json"

echo 'done. please restart your ide.'