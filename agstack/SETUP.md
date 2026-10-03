# Setting Up `agstack` for Antigravity CLI (`agy`)

This guide explains how to install, configure, and verify the `agstack` plugin for Google Antigravity CLI (`agy`).

`agstack` is the Antigravity-native port of [pstack](https://github.com/cursor/plugins/tree/main/pstack), providing 52 skills, 23 playbooks, 23 core engineering principles, subagent orchestrations, and runtime verification harnesses.

---

## Prerequisites

- **Google Antigravity CLI (`agy`)** installed and authenticated.
- **Git** installed on your system.
- Optional: **Node.js** (v18+) for running helper scripts or test runners.

---

## Installation Options

Choose either **Project-Level** (recommended for specific repos) or **Global** (available across all projects on your machine).

### Option A: Project-Level Setup (Single Repository)

Use this method when you want `agstack` enabled specifically for your current project.

1. **Place the plugin in your project:**
   Ensure `agstack` is placed inside your repository, for example under `plugins/agstack` (or `.agents/plugins/agstack`):
   ```text
   <your-project-root>/
   ├── .agents/
   │   ├── plugins.json
   │   └── skills.json
   └── plugins/
       └── agstack/
   ```

2. **Register the plugin in `.agents/plugins.json`:**
   Create or edit `<your-project-root>/.agents/plugins.json`:
   ```json
   {
     "entries": [
       {
         "path": "plugins/agstack"
       }
     ]
   }
   ```

3. **Register the skills in `.agents/skills.json` (for direct slash command indexing):**
   Create or edit `<your-project-root>/.agents/skills.json`:
   ```json
   {
     "entries": [
       {
         "path": "plugins/agstack/skills"
       }
     ]
   }
   ```

4. **Commit the configuration to Git:**
   Commit `.agents/plugins.json`, `.agents/skills.json`, and `plugins/agstack` so your entire team shares the same setup.

---

### Option B: Global Setup (Machine-Wide)

Use this method to make `agstack` available across every project you open in `agy`.

1. **Copy `agstack` to your Antigravity global configuration directory:**
   - **Windows (PowerShell):**
     ```powershell
     New-Item -ItemType Directory -Path "$env:USERPROFILE\.gemini\config\plugins" -Force
     Copy-Item -Path "plugins\agstack" -Destination "$env:USERPROFILE\.gemini\config\plugins\agstack" -Recurse
     ```
   - **macOS / Linux (Bash):**
     ```bash
     mkdir -p ~/.gemini/config/plugins
     cp -r plugins/agstack ~/.gemini/config/plugins/agstack
     ```

2. **Register in global `plugins.json`:**
   In your global configuration folder (`~/.gemini/config/plugins.json` or `%USERPROFILE%\.gemini\config\plugins.json`):
   ```json
   {
     "entries": [
       {
         "path": "~/.gemini/config/plugins/agstack"
       }
     ]
   }
   ```

3. **(Optional) Register skills globally:**
   In `~/.gemini/config/skills.json`:
   ```json
   {
     "entries": [
       {
         "path": "~/.gemini/config/plugins/agstack/skills"
       }
     ]
   }
   ```

---

## Initial Configuration: Setting Up Models

Once installed, configure your model preferences:

1. Launch Antigravity CLI:
   ```bash
   agy
   ```

2. Run the setup slash command:
   ```text
   /setup-pstack
   ```

3. **Select your Reasoning Budget:**
   - **Max Reasoning** (`pro` for judgment, architecture, synthesis, and reviews; `flash` for implementation delegates and parallel workers).
   - **All Pro** (`pro` for all roles).
   - **Fast / Efficient** (`flash` for delegates, `inherit` for parent matching).

4. This writes or updates `plugins/agstack/rules/AGENTS.md` (or `.agents/rules/pstack-models.md`), setting the model tier mappings:

| Role | Default Antigravity Model Tier |
| :--- | :--- |
| `feature`, `refactoring`, `bug-fix`, `perf-issue`, `hillclimb` | `flash` |
| `judgment and prose`, `hardest tasks` | `pro` |
| `architect`, `interrogate reviewers` | `pro` |
| `arena cross-judge` | `pro` |
| `arena runners` | `pro`, `flash` |
| `swarm workers` | `flash` |
| `how explorer`, `why investigators` | `flash` |
| `how explainer`, `why synthesizer` | `pro` |

---

## Verifying Your Setup

To confirm that `agstack` is recognized and operating properly:

1. **Check loaded slash commands:**
   In `agy`, type `/` to view the command completion menu. You should see:
   - `/poteto-mode`
   - `/setup-pstack`
   - `/architect`
   - `/arena`
   - `/swarm`
   - `/interrogate`
   - `/deslop`
   - `/control-cli`
   - `/control-ui`
   - `/babysit`
   - `/no-comments`
   - ... and all 23 `/principle-*` skills.

2. **Execute a test command:**
   Test `poteto-mode` with a real prompt:
   ```text
   /poteto-mode add a unit test for helper X. repro first, then verify.
   ```
   Confirm that the agent:
   - Matches the task to the **Bug fix** or **Feature** playbook.
   - Names the domain data shape and organizing structure.
   - Enforces runtime verification before reporting completion.

---

## Core Slash Commands Reference

| Slash Command | Primary Use Case |
| :--- | :--- |
| `/poteto-mode` | Main entry point for rigorous engineering tasks across 23 playbooks. |
| `/setup-pstack` | Interactively configure role-to-model tier assignments. |
| `/architect` | Sketch types, signatures, and module structure before writing code. |
| `/arena` | Spawn N parallel candidate prototypes using isolated `Workspace: 'branch'`. |
| `/swarm` | Fan out N parallel worker subagents across test matrices or races. |
| `/interrogate` | Run adversarial multi-perspective code reviews before shipping. |
| `/deslop` | Strip AI-generated code slop, excessive defensive checks, and unearned abstractions. |
| `/control-cli` | Drive and inspect interactive CLIs/TUIs with a local test harness (tmux/PTY). |
| `/control-ui` | Drive and inspect web/Electron UIs with Playwright/CDP harnesses. |
| `/babysit` | Drive PR branches and stacks to merge-ready (conflicts, review comments, CI). |
| `/no-comments` | Strip comments and flag workaround code using Comment Sicko. |
| `/unslop` | Remove AI tells, corporate filler, and jargon from prose. |
| `/show-me-your-work` | Maintain an auditable decision trail in `decisions.tsv`. |
| `/create-skill` | Author new Antigravity skills following progressive disclosure standards. |

---

## Troubleshooting

- **Skills not showing up in `/` menu:**
  - Verify that `.agents/plugins.json` and `.agents/skills.json` paths are correct relative to the workspace root.
  - Run `agy` from the repository root containing `.agents/`.
- **Model errors during subagent fan-out:**
  - Run `/setup-pstack` to reconfigure tiers. In Antigravity CLI, valid model tiers are `pro`, `flash`, `flash_lite`, and `inherit`.
- **Subagents stuck in background:**
  - Antigravity uses reactive wakeups; you do not need to poll. Use `manage_subagents` with action `list` or `status` to inspect running subagents.
