# openstack (pstack for OpenCode)

Rigorous agentic engineering workflows adapted for OpenCode (`opencode`).

Original design and philosophy by [poteto](https://x.com/poteto) (Lauren Tan).

AI often writes too much slop code. Throughput without quality is not a goal to aspire to. If you want to go fast, go deep first. **openstack** brings the rigorous engineering discipline of pstack to OpenCode.

**openstack gives you fearless parallelism.** When you can go deep on one agent and trust it to write good, verifiable code, you can truly parallelize with confidence. Launch parallel workers and candidate bakeoffs with OpenCode subagents (`@poteto-agent`, `@comment-sicko`) and custom slash commands.

---

## Installation & Setup

For full installation and setup instructions, see:
👉 [**`SETUP.md`**](./SETUP.md)

### 1. Project-Level (Current Workspace)

Configure `.opencode/opencode.json` in your repository root:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "skills": [
    "plugins/openstack/skills"
  ],
  "instructions": [
    "plugins/openstack/rules/AGENTS.md"
  ]
}
```

Copy or link `agents/` and `commands/` from `plugins/openstack/` into `.opencode/`.

### 2. Global Machine Installation

Copy `openstack` components into your OpenCode global directory:
- Linux/macOS: `~/.config/opencode/`
- Windows: `%USERPROFILE%\.config\opencode\`

---

## Getting Started

1. Run [`/setup-openstack`](./skills/setup-openstack/SKILL.md) to inspect and configure model delegation preferences and scope.
2. Use [`/poteto-mode`](./skills/poteto-mode/SKILL.md) whenever you need deep engineering rigor.

---

## Core Slash Commands

| Slash Command | Primary Use Case |
| :--- | :--- |
| `/poteto-mode` | Main entry point for rigorous engineering tasks across 23 playbooks. |
| `/setup-openstack` | Interactively configure scope and model policies in OpenCode. |
| `/architect` | Sketch types, signatures, and module structure before writing code. |
| `/arena` | Spawn parallel candidate prototypes and graft the strongest ideas into one base. |
| `/swarm` | Fan out parallel worker subagents across test matrices or races. |
| `/interrogate` | Run adversarial multi-perspective code reviews before shipping. |
| `/deslop` | Strip AI-generated code slop, excessive defensive checks, and unearned abstractions. |
| `/control-cli` | Drive and inspect interactive CLIs/TUIs with a local test harness (tmux/PTY). |
| `/control-ui` | Drive and inspect web/Electron UIs with Playwright/CDP harnesses. |
| `/babysit` | Drive PR branches and stacks to merge-ready (conflicts, review comments, CI). |
| `/no-comments` | Strip comments and flag workaround code using Comment Sicko. |
| `/unslop` | Remove AI tells, corporate filler, and jargon from prose. |
| `/show-me-your-work` | Maintain an auditable decision trail in `decisions.tsv`. |
| `/create-skill` | Author new OpenCode skills following progressive disclosure standards. |

---

## Included Skills & Playbooks

`openstack` bundles all 52 skills:
- **Core Orchestration**: `poteto-mode` (with all 23 playbooks in `playbooks/`).
- **Design & Architecture**: `architect`, `arena`, `how`, `why`.
- **Review & Hygiene**: `interrogate`, `deslop`, `no-comments`, `unslop`, `technical-writing`.
- **Verification Harnesses**: `control-cli`, `control-ui`, `tdd`, `create-verification-skill`.
- **23 Engineering Principles**: `principle-model-the-domain`, `principle-boundary-discipline`, `principle-laziness-protocol`, `principle-prove-it-works`, `principle-fix-root-causes`, and 18 others.
