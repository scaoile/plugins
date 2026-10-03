---
name: deslop
description: Remove AI-generated code slop, excessive defensive checks, and unearned abstractions from code changes. Use for /deslop, 'clean code slop', or pre-commit code polish.
---

# Remove AI Code Slop

Check the diff against main and remove AI-generated slop introduced in the branch.

## Focus Areas

- **Unnecessary comments**: Remove narration comments, obvious step markers, and commented-out dead code.
- **Defensive guards**: Strip unearned try/catch blocks or nil-checks on trusted internal code paths.
- **Type escapes**: Remove casts to `any` or `@ts-ignore` used to bypass type issues without fixing underlying types.
- **Deep nesting**: Simplify nested branching with early returns and guard clauses.
- **Premature abstractions**: Collapse single-caller wrappers, unused helpers, and speculatively generalized functions.

## Guardrails

- Keep runtime behavior unchanged unless fixing a confirmed bug.
- Prefer minimal, focused edits over broad rewrites.
- Keep the final summary concise (1-3 sentences).
