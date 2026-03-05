# OpenClaw Runtime Setup (Portable)

This folder stores a portable setup for the local OpenClaw runtime (`~/.openclaw`).

## What it installs

- `~/.openclaw/openclaw.json` (rendered from template)
- `~/.openclaw/workspace-scheduler/*` baseline files

## Required environment variables

- `MINIMAX_API_KEY`
- `OPENCLAW_TELEGRAM_BOT_TOKEN`

Optional:

- `OPENCLAW_HOME` (default: `~/.openclaw`)
- `OPENCLAW_GATEWAY_TOKEN` (generated automatically if missing)

## Install

```bash
MINIMAX_API_KEY=... \
OPENCLAW_TELEGRAM_BOT_TOKEN=... \
bash setup/openclaw/install-local.sh
```

Then restart gateway:

```bash
openclaw gateway restart
openclaw gateway status --json
```

## Remote safety (fork + upstream)

Set remote URLs and disable upstream push:

```bash
OPENCLAW_FORK_REMOTE_URL=git@github.com:<you>/openclaw.git \
bash setup/openclaw/configure-remotes.sh /path/to/repo
```

`upstream` push is forced to `no_push`.
