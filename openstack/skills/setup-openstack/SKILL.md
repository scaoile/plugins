---
name: setup-openstack
description: Configure model assignments and execution scope for openstack roles in OpenCode. Use for /setup-openstack, 'configure openstack models', or setting up OpenCode subagent policies.
---

# Setup openstack

Configure role-to-model assignments and installation scope for OpenCode. Writes an OpenCode rule (`plugins/openstack/rules/AGENTS.md`, `.opencode/rules/AGENTS.md`, or `~/.config/opencode/AGENTS.md`) defining how subagents and playbooks execute.

## Steps

### 1. Detect Available OpenCode Model Preferences

OpenCode is model-agnostic. By default, subagents inherit the active session model (`inherit`):
- **`inherit` (Default)**: Matches the calling session model without needing hardcoded model strings.
- **Explicit Provider Models**: Allows configuring specific models like `anthropic/claude-3-5-sonnet`, `google/gemini-2.5-pro`, or `openai/gpt-4o` for particular roles.

### 2. Load Current State

Check if `plugins/openstack/rules/AGENTS.md` or `.opencode/rules/AGENTS.md` already defines model assignments. Otherwise start from standard defaults:
- All roles: `inherit` (inherits active session model)

### 3. Scope and Policy Selection

**(a) Select Scope:**
- `Apply to this project only (.opencode/rules/AGENTS.md)` (Recommended when working inside a specific repository)
- `Apply globally across all projects (~/.config/opencode/AGENTS.md)` (Recommended when configuring global machine defaults)

**(b) Select Delegation Strategy:**
- `Inherit Session Model (Recommended - all subagents use the active session model)`
- `Split Tier (High reasoning for architect/judgment, fast model for workers)`

### 4. Write Configuration Rule

Write the updated configuration based on the chosen scope:
- If **Project Scope**: Write to `<workspace-root>/.opencode/rules/AGENTS.md`. OpenCode prioritizes project-level rules over global rules.
- If **Global Scope**: Write to `~/.config/opencode/AGENTS.md`. This sets the default across all repositories on your system.

Format:
```markdown
# openstack Model Configuration

subagent_policy: inherit
feature, refactoring: inherit
bug-fix: inherit
perf-issue: inherit
hillclimb: inherit
judgment and prose: inherit
hardest tasks: inherit
how explorer: inherit
how explainer: inherit
why investigators: inherit
why synthesizer: inherit
arena runners: inherit
arena cross-judge: inherit
swarm workers: inherit
architect runners: inherit
interrogate reviewers: inherit
```

### 5. Confirm

Inform the user that the OpenCode configuration rule has been updated and will govern future subagent invocations.
