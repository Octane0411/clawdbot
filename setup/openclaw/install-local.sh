#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TEMPLATE_DIR="$REPO_ROOT/setup/openclaw/templates"
TARGET_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
TARGET_CFG="$TARGET_HOME/openclaw.json"
TARGET_WORKSPACE="$TARGET_HOME/workspace-scheduler"

require_env() {
  local key="$1"
  if [[ -z "${!key:-}" ]]; then
    echo "Missing required env: $key" >&2
    exit 1
  fi
}

escape_sed() {
  printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'
}

require_env MINIMAX_API_KEY
require_env OPENCLAW_TELEGRAM_BOT_TOKEN

GATEWAY_TOKEN="${OPENCLAW_GATEWAY_TOKEN:-}"
if [[ -z "$GATEWAY_TOKEN" ]]; then
  GATEWAY_TOKEN="$(openssl rand -hex 24)"
fi

mkdir -p "$TARGET_HOME" "$TARGET_WORKSPACE"

if [[ -f "$TARGET_CFG" ]]; then
  cp "$TARGET_CFG" "$TARGET_CFG.bak.$(date +%Y%m%d%H%M%S)"
fi

cp -R "$TEMPLATE_DIR/workspace-scheduler/." "$TARGET_WORKSPACE/"

MINIMAX_ESC="$(escape_sed "$MINIMAX_API_KEY")"
TG_ESC="$(escape_sed "$OPENCLAW_TELEGRAM_BOT_TOKEN")"
GW_ESC="$(escape_sed "$GATEWAY_TOKEN")"
HOME_ESC="$(escape_sed "$TARGET_HOME")"

sed \
  -e "s/@@MINIMAX_API_KEY@@/$MINIMAX_ESC/g" \
  -e "s/@@TELEGRAM_BOT_TOKEN@@/$TG_ESC/g" \
  -e "s/@@GATEWAY_TOKEN@@/$GW_ESC/g" \
  -e "s#@@OPENCLAW_HOME@@#$HOME_ESC#g" \
  "$TEMPLATE_DIR/openclaw.json" > "$TARGET_CFG"

echo "Installed OpenClaw setup to: $TARGET_HOME"
echo "- config: $TARGET_CFG"
echo "- workspace: $TARGET_WORKSPACE"
echo
echo "Next:"
echo "1) openclaw gateway restart"
echo "2) openclaw gateway status --json"
