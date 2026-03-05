# HEARTBEAT

Every 30 minutes:

1. Check open PRs from fork to upstream.
2. Check CI/review status.
3. If blocked and fixable, dispatch Codex CLI run.
4. If no action needed, return `HEARTBEAT_OK`.

Autopilot rule:

- Do not request confirmation for routine steps.
- Escalate only on hard blockers.
