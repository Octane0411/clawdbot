# HEARTBEAT

Every 30 minutes:

1. Check open PRs from fork to upstream.
2. Check CI/review status.
3. If review asks for an in-scope fix, dispatch Codex to update that PR.
4. If PR is clearly duplicate/superseded/already-landed:
   - create or identify the replacement PR
   - comment old PR with `Superseded by #<new-pr-number> (<short reason>).`
   - close old PR
5. If blocked and fixable, dispatch Codex CLI run.
6. If no action is needed, return `HEARTBEAT_OK`.

Autopilot rule:

- Do not request confirmation for routine steps.
- Escalate only on hard blockers.
- If task flow cannot complete, return `HARD_BLOCKER` and stop (no manual fallback).
