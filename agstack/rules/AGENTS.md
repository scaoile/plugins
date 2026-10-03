# agstack Rules & Operational Guidelines

This document governs agent behavior when the `agstack` plugin is active in Antigravity CLI (`agy`).

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
- **No long dash characters**: Avoid em-dash (`—`) or en-dash (`–`) characters in prose. Format lists as clean sentences.
- **No mid-sentence colons**: Use colons only to introduce lists or indented blocks, never as mid-sentence connectors.
- **Evidence in the same sentence**: Every claim of fact carries its evidence or status label (`measured`, `inferred`, or `guess`).
- **Antigravity Artifacts**: For multi-step plans, review verdicts, architectural proposals, or complex summaries, use Antigravity Markdown Artifacts (`write_to_file` with `ArtifactMetadata`) with Mermaid diagrams and alerts rather than flooding the conversation turn.

---

## 3. Subagent Orchestration & Model Tiers

In Antigravity CLI, subagents are orchestrated using `invoke_subagent` and configured using `define_subagent`:

### Model Tier Mapping
- **`pro`**: High reasoning, deep judgment, architectural exploration, synthesis, and hardest changes.
  - Roles: `judgment and prose`, `hardest tasks`, `architect`, `interrogate lead reviewer`, `arena cross-judge`, `how explainer`, `why synthesizer`, `reflect synthesizer`.
- **`flash`**: Fast, efficient code implementation and parallel worker tasks.
  - Roles: `feature`, `refactoring`, `bug-fix`, `perf-issue`, `hillclimb`, `swarm workers`, `how explorer`, `why investigators`.
- **`inherit`**: Matches the calling agent's model tier. Used when running under uniform parent settings.

### Execution Conventions
- **Batched Fan-out**: Fan out parallel subagents in a single `invoke_subagent` call by populating the `Subagents` array.
- **Workspace Isolation**: When running parallel candidate bakeoffs (`arena`) or destructive prototyping, specify `Workspace: 'branch'`.
- **Reactive Wakeups**: Antigravity resumes automatically upon subagent completion. Do not poll or loop.
- **Agent Ownership**: The parent agent owns synthesis and verification. Always inspect the returned diff and artifact rather than passively trusting delegate summaries.

---

## 4. Subagent Definitions

When specialized subagents are required:
- **`poteto-agent`**: Full rigorous engineering agent style. Can be defined via `define_subagent(name="poteto-agent", ...)` reading `poteto-mode` in full.
- **`comment-sicko`**: Read-only / comment-elimination reviewer that strips unnecessary comments, banners, and dead code corpses while identifying refactor targets marked `MUST KILL`.
