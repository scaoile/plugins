---
name: automate-me
description: Draft or update a personal -mode skill tailored to your working preferences by mining recent conversation transcripts and prompting for conventions. Use for 'automate me', 'create my mode skill', or 'capture my working style'.
---

# Automate Me

A guided flow for turning your working conventions into an OpenCode skill that agents will follow. The output is one `-mode` skill tailored to you (e.g. `jay-mode`, `priya-mode`).

This skill orchestrates transcript mining, the **authoring-a-skill** workflow, and the **unslop** skill.

## Flow

### 0. Check for an Existing Skill

Look recursively for `.opencode/skills/*-mode/SKILL.md` or `~/.config/opencode/skills/*-mode/SKILL.md` matching your handle. If one exists, confirm intent with `ask_question`:
- Update the existing skill (default for repeat runs)
- Start fresh

### 1. Mine Session History

Locate the active workspace's transcripts at `<appDataDir>\brain\<conversation-id>\.system_generated\logs/transcript.jsonl`.

Survey recent agent conversations for recurring patterns:
- Response preferences (length, tone, format, directness)
- Delegation habits (subagents, model tiers, specialized workflows)
- Verification posture (unit tests vs live reproduction, runtime proof)
- Code and prose discipline (principles cited, lint/format tools)
- Process conventions (commits, PRs, review tools)

Cross-check patterns across conversations before elevating a signal.

### 2. Ask the User Directly

Use the `ask_question` tool with structured multiple-choice options:
- Category priorities: "Which areas matter most in your workflow?"
- Specific preferences for selected areas.
- Follow up with a free-form question for edge cases.

### 3. Cluster Findings

Group signals into concise sections:
- **Response style**: length, tone, structure.
- **Autonomy**: MCP tools, shell commands, actions requiring confirmation.
- **Understand first**: preferred exploration and design workflows (`/how`, `/why`, `/architect`).
- **Subagents**: model tiers, parallel fan-out habits.
- **Verification**: runtime proof, repro steps, test assertions.

### 4. Draft the Skill

Author the skill following OpenCode's standard:
- Placement: `.opencode/skills/<handle>-mode/SKILL.md` (or `~/.config/opencode/skills/<handle>-mode/SKILL.md` for global availability).
- YAML Frontmatter:
  ```markdown
  ---
  name: <handle>-mode
  description: <User>'s custom engineering mode for OpenCode. Use for /<handle>-mode or requests to work in <user>'s style.
  ---
  ```

### 5. Iterate & Polish

Apply the **unslop** skill to ensure clean, terse sentences. Show the draft to the user via an Markdown document and refine based on feedback.
