# Setting Up `openstack` for OpenCode

This guide explains how to install, configure, and verify the `openstack` plugin for OpenCode (`opencode`).

`openstack` is the OpenCode-native port of `pstack`, providing 52 skills, 23 playbooks, 23 core engineering principles, subagents (`@poteto-agent`, `@comment-sicko`), and custom slash commands.

---

## Prerequisites

- **OpenCode CLI (`opencode`)** installed and authenticated.
- **Git** installed on your system.
- Optional: **Bun** or **Node.js** (v18+) for running test runners and scripts.

---

## Retrieving `openstack` from GitHub

You can retrieve the `openstack` plugin from GitHub using any of the following methods.

### Method 1: Git Sparse-Checkout (Recommended)

Use this method to download only the `openstack` directory without downloading the entire repository.

**Windows (PowerShell):**
```powershell
git clone --depth 1 --filter=blob:none --sparse https://github.com/scaoile/plugins.git temp-plugins
cd temp-plugins
git sparse-checkout set openstack
Move-Item -Path "openstack" -Destination "..\plugins\openstack"
cd ..
Remove-Item -Path "temp-plugins" -Recurse -Force
```

**macOS / Linux (Bash):**
```bash
git clone --depth 1 --filter=blob:none --sparse https://github.com/scaoile/plugins.git temp-plugins
cd temp-plugins
git sparse-checkout set openstack
mv openstack ../plugins/openstack
cd ..
rm -rf temp-plugins
```

### Method 2: Git Submodule (Project-Level Integration)

Use this method to pin the repository as a tracked dependency inside an existing project.

In the root of your target repository:
```bash
git submodule add https://github.com/scaoile/plugins.git plugins
```

### Method 3: Full Git Clone

Use this method to clone the full repository.

```bash
git clone https://github.com/scaoile/plugins.git
cd plugins/openstack
```

### Method 4: Direct Archive Download (No Git Required)

Use this method to extract the files without using Git commands.

**Windows (PowerShell):**
```powershell
Invoke-WebRequest -Uri "https://github.com/scaoile/plugins/archive/refs/heads/main.zip" -OutFile "plugins.zip"
Expand-Archive -Path "plugins.zip" -DestinationPath "temp-plugins"
New-Item -ItemType Directory -Path "plugins" -Force
Move-Item -Path "temp-plugins\plugins-main\openstack" -Destination "plugins\openstack"
Remove-Item -Path "temp-plugins" -Recurse -Force
Remove-Item -Path "plugins.zip"
```

**macOS / Linux (Bash):**
```bash
curl -L -o plugins.tar.gz https://github.com/scaoile/plugins/archive/refs/heads/main.tar.gz
tar -xzf plugins.tar.gz
mkdir -p plugins
mv plugins-main/openstack plugins/openstack
rm -rf plugins-main plugins.tar.gz
```

---

## Installation Options

Choose either **Project-Level** (recommended for specific repositories) or **Global** (available across all projects on your machine).

### Option A: Project-Level Setup (Single Repository)

Use this method when you want `openstack` enabled specifically for your current project.

1. **Place the plugin in your project:**
   Ensure `openstack` is placed inside your repository, for example under `plugins/openstack`:
   ```text
   <your-project-root>/
   ├── .opencode/
   │   ├── opencode.json
   │   ├── agents/
   │   │   ├── poteto-agent.md
   │   │   └── comment-sicko.md
   │   └── commands/
   │       ├── poteto-mode.md
   │       └── ...
   └── plugins/
       └── openstack/
           └── skills/
   ```

2. **Register the plugin in `.opencode/opencode.json`:**
   Create or edit `<your-project-root>/.opencode/opencode.json`:
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

3. **Link or copy agents and commands:**
   Copy the `agents/` and `commands/` folders from `plugins/openstack/` into your project's `.opencode/` directory:
   - **Windows (PowerShell):**
     ```powershell
     Copy-Item -Path "plugins\openstack\agents" -Destination ".opencode\agents" -Recurse -Force
     Copy-Item -Path "plugins\openstack\commands" -Destination ".opencode\commands" -Recurse -Force
     ```
   - **macOS / Linux (Bash):**
     ```bash
     mkdir -p .opencode
     cp -r plugins/openstack/agents .opencode/agents
     cp -r plugins/openstack/commands .opencode/commands
     ```

4. **Commit the configuration to Git:**
   Commit `.opencode/` and `plugins/openstack` so your team shares the setup.

---

### Option B: Global Setup (Machine-Wide)

Use this method to make `openstack` available across every project you open in OpenCode.

1. **Copy skills, agents, commands, and rules to your OpenCode global configuration directory:**

   - **Windows (PowerShell):**
     ```powershell
     $globalDir = "$env:USERPROFILE\.config\opencode"
     New-Item -ItemType Directory -Path "$globalDir\skills" -Force
     New-Item -ItemType Directory -Path "$globalDir\agents" -Force
     New-Item -ItemType Directory -Path "$globalDir\commands" -Force
     Copy-Item -Path "plugins\openstack\skills\*" -Destination "$globalDir\skills\" -Recurse -Force
     Copy-Item -Path "plugins\openstack\agents\*" -Destination "$globalDir\agents\" -Recurse -Force
     Copy-Item -Path "plugins\openstack\commands\*" -Destination "$globalDir\commands\" -Recurse -Force
     Copy-Item -Path "plugins\openstack\rules\AGENTS.md" -Destination "$globalDir\AGENTS.md" -Force
     ```

   - **macOS / Linux (Bash):**
     ```bash
     globalDir="$HOME/.config/opencode"
     mkdir -p "$globalDir/skills" "$globalDir/agents" "$globalDir/commands"
     cp -r plugins/openstack/skills/* "$globalDir/skills/"
     cp -r plugins/openstack/agents/* "$globalDir/agents/"
     cp -r plugins/openstack/commands/* "$globalDir/commands/"
     cp plugins/openstack/rules/AGENTS.md "$globalDir/AGENTS.md"
     ```

2. **Verify global files:**
   Confirm that `~/.config/opencode/skills/poteto-mode/SKILL.md` and `~/.config/opencode/AGENTS.md` exist.

---

## Subagents & Model Policy

In OpenCode, subagents inherit the active parent session model by default:
- You do not need to hardcode model strings.
- If you start OpenCode with Claude, Gemini, or local models, all subagents inherit that model.
- Run `/setup-openstack` inside OpenCode to choose between global and project-level settings.

---

## Verifying Your Setup

To confirm that `openstack` is recognized and operating properly:

1. **Check loaded slash commands:**
   In OpenCode, type `/` to view the command autocomplete menu. You should see:
   - `/poteto-mode`
   - `/setup-openstack`
   - `/architect`
   - `/arena`
   - `/swarm`
   - `/interrogate`
   - `/deslop`
   - `/control-cli`
   - `/control-ui`
   - `/babysit`
   - `/no-comments`
   - `/show-me-your-work`

2. **Check specialized subagents:**
   Type `@` in OpenCode chat to confirm:
   - `@poteto-agent`
   - `@comment-sicko`

3. **Execute a test command:**
   Run `poteto-mode` with a task:
   ```text
   /poteto-mode add a unit test for helper X. repro first, then verify.
   ```
   Confirm that the agent:
   - Matches the task to the **Bug fix** or **Feature** playbook.
   - Identifies the domain data shape and organizing structure.
   - Enforces runtime verification before reporting completion.

---

## Core Slash Commands Reference

| Slash Command | Primary Use Case |
| :--- | :--- |
| `/poteto-mode` | Main entry point for rigorous engineering tasks across 23 playbooks. |
| `/setup-openstack` | Interactively configure scope and subagent policies in OpenCode. |
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

## Troubleshooting

- **Commands not appearing in `/` autocomplete:**
  - Verify that `.opencode/commands/` contains the `.md` command files.
  - Or verify that `.opencode/opencode.json` declares the commands.
- **Skills not triggering:**
  - Verify that `.opencode/opencode.json` contains `"skills": ["plugins/openstack/skills"]`.
- **Subagents not found:**
  - Check that `.opencode/agents/poteto-agent.md` exists with frontmatter `mode: subagent`.
