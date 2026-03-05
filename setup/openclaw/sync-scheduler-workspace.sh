#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TARGET_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
TARGET_WORKSPACE="$TARGET_HOME/workspace-scheduler"
ACTIVE_FILE="$REPO_ROOT/.autopr/profile.active"
PROFILES_DIR="$REPO_ROOT/.autopr/profiles"

usage() {
  cat <<'USAGE'
Usage:
  bash setup/openclaw/sync-scheduler-workspace.sh [profile]
USAGE
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

default_profile="baseline"
if [[ -f "$ACTIVE_FILE" ]]; then
  default_profile="$(tr -d '[:space:]' < "$ACTIVE_FILE")"
fi

profile="${1:-${OPENCLAW_AUTOPR_PROFILE:-$default_profile}}"
profile_dir="$PROFILES_DIR/$profile"

if [[ ! -d "$profile_dir" ]]; then
  echo "Unknown profile: $profile" >&2
  echo "Expected: $profile_dir" >&2
  exit 1
fi

mkdir -p "$TARGET_WORKSPACE"
cp "$profile_dir/workspace-scheduler/AGENTS.md" "$TARGET_WORKSPACE/AGENTS.md"
cp "$profile_dir/workspace-scheduler/HEARTBEAT.md" "$TARGET_WORKSPACE/HEARTBEAT.md"

echo "Synced scheduler workspace profile '$profile' to: $TARGET_WORKSPACE"
