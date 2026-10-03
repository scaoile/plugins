---
name: create-skill
description: Author a new Antigravity skill with standard directory structure, YAML frontmatter, and verification steps. Use for /create-skill, 'author a skill', or 'make a new skill'.
---

# Create Skill

A structured guide for authoring new skills for Google Antigravity CLI (`agy`).

## Skill Directory Structure

In Antigravity CLI, every skill lives in its own directory inside a customization root:
- **Workspace-specific**: `.agents/skills/<skill-name>/`
- **Plugin-bundled**: `plugins/<plugin-name>/skills/<skill-name>/`
- **Global**: `~/.gemini/config/skills/<skill-name>/`

```text
skills/<skill-name>/
├── SKILL.md          # Required: Main instruction file with YAML frontmatter
├── scripts/          # Optional: Helper scripts and utilities
├── examples/         # Optional: Reference implementations
├── resources/        # Optional: Additional assets or templates
└── references/       # Optional: Detailed documentation or manuals
```

## Frontmatter Requirements

The `SKILL.md` file must start with a YAML frontmatter block containing:
- **`name`** (string, required): A unique, lowercase, hyphenated identifier (e.g. `verify-auth-flow`).
- **`description`** (string, required): Third-person instruction describing **what** the skill does and **when** it should be triggered. Antigravity uses this description for progressive disclosure and semantic matching.

```markdown
---
name: my-new-skill
description: Execute integration smoke tests for service X. Use for /my-new-skill, "run smoke tests", or when deploying to staging.
---

# My New Skill

Provide step-by-step instructions for the agent here.

## Steps

1. Check environment variables.
2. Execute test command: `npm test`.
3. Verify test output.
```

## Best Practices

1. **Progressive Disclosure**: Keep `SKILL.md` concise. Put bulky documentation or detailed tables in `references/` and link to them relatively.
2. **Deterministic Scripts**: Place complex commands in `scripts/` (provide both `.sh` and `.ps1` for cross-platform support).
3. **Runtime Verification**: Always instruct the agent on how to verify success using real artifacts.
4. **Unslop Prose**: Use short declarative sentences, no long dashes, and no mid-sentence colons.
