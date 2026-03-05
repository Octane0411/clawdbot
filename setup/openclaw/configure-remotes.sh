#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-$(pwd)}"
FORK_URL="${OPENCLAW_FORK_REMOTE_URL:-}"
UPSTREAM_URL="${OPENCLAW_UPSTREAM_REMOTE_URL:-git@github.com:openclaw/openclaw.git}"

if [[ -z "$FORK_URL" ]]; then
  echo "Missing OPENCLAW_FORK_REMOTE_URL (example: git@github.com:<user>/openclaw.git)" >&2
  exit 1
fi

cd "$REPO_ROOT"

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$FORK_URL"
else
  git remote add origin "$FORK_URL"
fi

if git remote get-url upstream >/dev/null 2>&1; then
  git remote set-url upstream "$UPSTREAM_URL"
else
  git remote add upstream "$UPSTREAM_URL"
fi

git remote set-url --push upstream no_push

echo "Remotes configured:"
git remote -v | sed -n '1,20p'
