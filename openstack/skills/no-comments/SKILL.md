---
name: no-comments
description: Spawn Comment Sicko to strip comments, fix accepted findings, and identify MUST KILL refactor targets. Use for /no-comments, 'clean comments', 'strip comments', or pre-review comment hygiene.
---

# No Comments

Spawn Comment Sicko. Act on accepted findings.

Defer to Comment Sicko's fresh perspective.

## Scope

Use the caller's files or diff. Otherwise use the current diff against the base branch (default `main`), including the working tree.

## Steps

1. If not already registered in this session, define `comment-sicko` via `define_subagent` using the prompt in `agents/comment-sicko.md`.
2. Spawn `invoke_subagent` with `TypeName: "comment-sicko"` and `Model: "flash"`. Pass the scope. Do not restate its rules.
3. Inspect its report and diff. Reject application-code edits, scope escapes, exception-protected deletions, misstated `MUST KILL` reasons, and flags that treat kept intentional code as guilty. Reshape flags on our-code surprises stay actionable. Do not restore those comments. A keep survives only with proof it is about something we cannot change. Audit missed scoped lint and TypeScript suppressions. Correctness or safety suppressions stay actionable `MUST KILL`s. Restore deletions only with exact exceptions and scoped proof. Before accepting thin `IMPORTANT` or `do not remove` kills or keeps, run `/how` or `/why` on their symbol.
4. Fix trivial accepted flags directly by deleting a dead path, dropping a parameter, or using the real API. If any fix needs a shape, run `/architect` once for the accepted set and surrounding code.
5. Implement the smallest root-cause fix in scope. Remove every named workaround. If the root cause is out of scope, land the smallest in-scope fix and report the rest open. The **principle-fix-root-causes** and **principle-redesign-from-first-principles** skills guide intent only. Never bolt on symptom guards.
6. Constraint comments say `do not remove`, `do not change wording`, or `talk to X before changing`. Offer the cheapest in-scope type, runtime, test, or CI lint. Ask the user via `ask_question` for approval. If approved, encode then delete.
7. Report the deletion count, restored comments, reruns, fixes, encodings, and any open refactor targets.
