---
name: babysit
description: Drive a pull request or stack of PRs to merge-ready. Handles rebase conflicts, review comment triage, and CI failure loops. Use for /babysit, 'babysit this', 'get it green', or 'check on PR X'.
---

# Babysit

Drive a PR or stack of PRs to merge-ready: conflicts, review threads, and CI.

Follow the complete instructions and workflow in the [Babysit Playbook](../poteto-mode/playbooks/babysit.md).

## Modes

1. **`drive`**: Runs the loop to merge-ready (for "babysit this", "get it green", "merge-ready").
2. **`check`**: One status pass and a report (for "check on PR X", "is it green").
3. **`threads-only`**: Answers review comments and touches nothing else.
4. **`background`**: Triages without blocking active plans.

## Key Rules

- Work the merge frontier (the lowest unmerged PR) and nothing above it.
- Never mutate stack topology from inside a babysit.
- Trust the active forge's verdict (`gh` or `origin`), not a green check list.
- Triage automated comments skeptically; never churn code to quiet a bot.
- Stop when merge-ready. Landing the stack is handled by `/poteto-mode` with the [Shipping Playbook](../poteto-mode/playbooks/shipping.md).
