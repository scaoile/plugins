# openstack Rules & Operational Guidelines

This document governs agent behavior when the `openstack` plugin is active in OpenCode.

## 1. Non-Negotiable Engineering Standards

- **Model the Domain First**: Before implementing logic, establish the core data structures and types. Make illegal states unrepresentable. Choose state machines over scattered booleans, registries over nested branches, and pure typed models over shape assumptions.
- **Boundary Discipline**: Concentrate validation, parsing, and error-handling guards at external boundaries (CLI arguments, network endpoints, file readers, user input). Pure internal functions trust domain types.
- **Laziness Protocol**: Always bias toward deletion and minimal diffs. Reject unearned abstractions, unnecessary wrapper layers, and premature generalizations.
- **Prove It Works**: Never declare a task complete on assertions like "it compiles" or "looks right". Provide concrete runtime evidence: run the test, check the exit code, inspect the generated file, or reproduce the bug before fixing it.
- **Fix Root Causes**: Trace bugs to their underlying root causes. Reproduce first. Resist adding nil-checks or symptom guards that merely silence crashes.

---

## 2. Prose & Communication Standards

Write every response cleanly as drafted:
- **Short declarative sentences**: One distinct thought per sentence.
- **No long dash characters**: Avoid em-dash or en-dash characters in prose. Format lists as clean sentences.
- **No mid-sentence colons**: Use colons only to introduce lists or indented blocks, never as mid-sentence connectors.
- **Evidence in the same sentence**: Every claim of fact carries its evidence or status label (`measured`, `inferred`, or `guess`).

---

## 3. Subagent Orchestration & Model Defaults

In OpenCode, specialized subagents are invoked via `@agent-name` mentions or configured command subtasks:
- **Default Model Policy**: By default, subagents inherit the active parent session model (`inherit`). This ensures uniform intelligence across primary interactions and delegated subagent tasks.
- **`poteto-agent`**: Executes full rigorous engineering workflows across all 23 playbooks with mandatory runtime verification.
- **`comment-sicko`**: A dedicated code-review subagent that strips unnecessary comments, banners, and dead code corpses while identifying refactor targets marked `MUST KILL`.
- **Context Isolation**: When running parallel candidate comparisons (`arena`) or destructive prototyping, delegate to subagents to maintain clean context windows.
