---
name: setup-pstack
description: Configure model tier assignments and reasoning budget for agstack roles in Antigravity CLI. Use for /setup-pstack, 'configure pstack models', 'pstack budget', or modifying role-to-model assignments.
---

# Setup pstack (agstack)

Configure role-to-model assignments for Antigravity CLI. Writes an Antigravity rule (`plugins/agstack/rules/AGENTS.md` or `.agents/rules/pstack-models.md`) defining how subagents are tiered across roles.

## Steps

### 1. Detect Available Antigravity Model Tiers

Antigravity CLI provides standardized model tiers for subagents:
- **`pro`**: High reasoning, deep judgment, synthesis, and hardest tasks.
- **`flash`**: Fast, lightweight code implementation, test runs, and worker fan-outs.
- **`flash_lite`**: Minimal-latency quick checks.
- **`inherit`**: Matches the calling agent's current model.

### 2. Load Current State

Check if `plugins/agstack/rules/AGENTS.md` or `.agents/rules/pstack-models.md` already defines model assignments. Otherwise start from standard defaults:
- **Hardest tasks & judgment**: `pro`
- **Architect, interrogate reviewers, arena cross-judge**: `pro`
- **Code delegates (feature, bug-fix, perf, hillclimb)**: `flash`
- **Explorers & swarm workers**: `flash`

### 3. Budget, Scope, and Confirm

**(a) Ask for scope preference.** Use the `ask_question` tool:
- `Apply to this project only (.agents/rules/pstack-models.md)` (Recommended when working inside a specific repository)
- `Apply globally across all projects (~/.gemini/config/plugins/agstack/rules/AGENTS.md)` (Recommended when configuring global defaults)

**(b) Ask for a budget preference.** Use the `ask_question` tool:
- `Max Reasoning (pro for judgment & architecture, flash for implementation)` (Recommended)
- `All Pro (pro for all delegates and workers)`
- `Fast / Efficient (flash for delegates, inherit for parent)`

**(b) Role-to-Tier Mapping Table.** Present the configuration to the user:

| Role | Antigravity Tier |
| :--- | :--- |
| `feature, refactoring` | `flash` |
| `bug-fix` | `flash` |
| `perf-issue` | `flash` |
| `hillclimb` | `flash` |
| `judgment and prose` | `pro` |
| `hardest tasks` | `pro` |
| `how explorer` | `flash` |
| `how explainer` | `pro` |
| `why investigators` | `flash` |
| `why synthesizer` | `pro` |
| `arena runners` | `pro`, `flash` |
| `arena cross-judge` | `pro` |
| `swarm workers` | `flash` |
| `architect runners` | `pro`, `flash` |
| `interrogate reviewers` | `pro`, `pro`, `flash` |

### 4. Write the Configuration Rule

Write the updated configuration based on the chosen scope:
- If **Project Scope**: Write to `<workspace-root>/.agents/rules/pstack-models.md`. Antigravity CLI gives workspace-level rules higher priority than global rules.
- If **Global Scope**: Write to the global plugin rule file at `~/.gemini/config/plugins/agstack/rules/AGENTS.md` (or update `plugins/agstack/rules/AGENTS.md` in your global installation). This sets the default across all projects.

Format:
```markdown
# agstack Model Configuration
# Tier choices: pro, flash, flash_lite, inherit

feature, refactoring: flash
bug-fix: flash
perf-issue: flash
hillclimb: flash
judgment and prose: pro
hardest tasks: pro
how explorer: flash
how explainer: pro
why investigators: flash
why synthesizer: pro
arena runners: pro, flash
arena cross-judge: pro
swarm workers: flash
architect runners: pro, flash
interrogate reviewers: pro, pro, flash
```

### 5. Confirm

Inform the user that the rule has been written and will govern all future subagent calls.
