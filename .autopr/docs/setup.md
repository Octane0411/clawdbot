# AutoPR Setup on a New Machine

## 0) Restore OpenClaw runtime from repo (portable setup)

1. Install runtime config + scheduler workspace:
   - `MINIMAX_API_KEY=... OPENCLAW_TELEGRAM_BOT_TOKEN=... bash setup/openclaw/install-local.sh`
2. Restart and verify gateway:
   - `openclaw gateway restart`
   - `openclaw gateway status --json`

Optional remote safety bootstrap:

- `OPENCLAW_FORK_REMOTE_URL=git@github.com:<you>/openclaw.git bash setup/openclaw/configure-remotes.sh /path/to/repo`

1. Clone your fork repository.
2. Install dependencies:
   - `pnpm install`
3. Select AutoPR profile (A/B):
   - `pnpm autopr:profile -- list`
   - `pnpm autopr:profile -- apply <profile> --sync-runtime`
4. Enable git hooks path (repo already does this on prepare, but enforce once):
   - `git config core.hooksPath git-hooks`
5. Enforce remote naming:
   - `origin` => your fork
   - `upstream` => `openclaw/openclaw` (push disabled)
6. Verify OpenClaw profile exists and gateway is running.
7. Ensure scheduler/codex agents are present in `~/.openclaw/openclaw.json`.

## First task

1. `pnpm task:start <task-id> [area]`
2. `cd .worktrees/codex-<area>-<task-id>`
3. implement changes
4. `pnpm task:verify`
5. `pnpm task:pr:clean`
6. switch to created `clean/*` branch
7. `pnpm task:pr:open`
