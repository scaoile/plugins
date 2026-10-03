---
name: reflect
description: Spawn parallel review subagents over the active transcript, surface learnings, and route each to a concrete edit on an existing skill. Use for /reflect, "reflect", or post-task retrospectives.
---

# Reflect

Mine the current conversation for durable learnings, then route them into skill edits.

## When to Invoke

Invoke when the user says "reflect" or "/reflect". Skip when the conversation is trivial, off-topic, or already covered by an existing skill the parent followed correctly. One-offs are not learnings.

## Process

### 1. Locate the Active Transcript

In Antigravity CLI, transcripts are stored at `<appDataDir>\brain\<conversation-id>\.system_generated\logs/transcript.jsonl`.

### 2. Spawn Three Reviewers in Parallel

Launch all reviewers in a single `invoke_subagent` call with `Subagents: [...]`:

- **Judgment Reviewer** (`Model: "pro"`, `TypeName: "research"`, `Role: "Judgment Reviewer"`): Uses `references/judgment-reviewer.md`.
- **Tooling Reviewer** (`Model: "pro"`, `TypeName: "research"`, `Role: "Tooling Reviewer"`): Uses `references/tooling-reviewer.md`.
- **Divergent Reviewer** (`Model: "pro"`, `TypeName: "research"`, `Role: "Divergent Reviewer"`): Uses `references/divergent-reviewer.md`.

Pass each template substituting the transcript path or digest where marked. Reviewers return findings in their response.

### 3. Synthesize

Spawn one synthesizer subagent using `Model: "pro"` (or synthesize directly in lead agent), following `references/synthesizer.md` with each reviewer's findings. Returns a structured Accepted / Rejected / Backlog list.

### 4. Structural Enforcement Check

Sanity-check the synthesizer's Accepted list. For any item that would be enforced more reliably by a lint rule, script, metadata flag, or runtime check, move it from Accepted to Backlog. See the **encode-lessons-in-structure** principle skill.

### 5. Apply

Before applying any Accepted edit, present the synthesizer's output to the user as an Antigravity Markdown Artifact (`write_to_file` with `ArtifactMetadata`) and wait for explicit approval via `ask_question`.

For each approved Accepted item, follow the routing:
- Trivial edit: parent updates directly.
- Substantive edit: follow the **authoring-a-skill** workflow.
