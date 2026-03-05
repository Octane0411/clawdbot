# AutoPR Profiles

This folder stores versioned scheduler harness profiles for A/B testing.

Each profile owns:

- `.autopr/templates/pr-body.md` source
- `setup/openclaw/templates/workspace-scheduler/AGENTS.md` source
- `setup/openclaw/templates/workspace-scheduler/HEARTBEAT.md` source

## Active profile

The active profile is tracked in `.autopr/profile.active`.

Switch/apply profile to tracked template files:

```bash
bash scripts/autopr-profile apply <profile>
```

List profiles:

```bash
bash scripts/autopr-profile list
```

Sync active profile into local runtime workspace (`~/.openclaw/workspace-scheduler`):

```bash
bash scripts/autopr-profile apply <profile> --sync-runtime
```
