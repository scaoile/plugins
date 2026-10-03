# agstack (pstack for Google Antigravity CLI)

Rigorous agentic engineering workflows adapted for Google Antigravity CLI (`agy`).

Original design and philosophy by [poteto](https://x.com/poteto) (Lauren Tan).

AI often writes too much slop code. Throughput without quality is not a goal to aspire to. If you want to go fast, go deep first. **agstack** brings the rigorous engineering discipline of pstack to Google Antigravity CLI.

**agstack gives you fearless parallelism.** When you can go deep on one agent and trust it to write good, verifiable code, you can truly parallelize with confidence. Launch parallel workers and candidate bakeoffs with Antigravity subagents (`invoke_subagent`, `define_subagent`) and native workspace branching (`Workspace: 'branch'`).

---

## Installation & Setup

### 1. Project-Level (Current Workspace)

`agstack` is already registered in this workspace via `.agents/plugins.json` and `.agents/skills.json`:

```json
// .agents/plugins.json
{
  "entries": [
    { "path": "plugins/agstack" }
  ]
}
```

```json
// .agents/skills.json
{
  "entries": [
    { "path": "plugins/agstack/skills" }
  ]
}
```

### 2. Global Machine Installation

To make `agstack` available across all workspaces on your machine:
Copy `plugins/agstack` into your global configuration directory:
- Linux/macOS: `~/.gemini/config/plugins/agstack`
- Windows: `%USERPROFILE%\.gemini\config\plugins\agstack`

Or register it in `~/.gemini/config/plugins.json`.

---

## Getting Started

1. Run [`/setup-pstack`](./skills/setup-pstack/SKILL.md) to inspect and configure Antigravity model tiers (`pro`, `flash`, `inherit`).
2. Use [`/poteto-mode`](./skills/poteto-mode/SKILL.md) whenever you need deep engineering rigor.

The mode splits work by Antigravity model tier:
- **`flash`**: Code delegates (`feature`, `refactoring`, `bug-fix`, `perf-issue`, `hillclimb`, `swarm workers`).
- **`pro`**: Hardest changes, architectural synthesis, prose, cross-judging (`arena`), and adversarial reviews (`interrogate`).
- **`inherit`**: Matches the calling agent's model tier.

---

## Usage: Just Use `/poteto-mode`

[`/poteto-mode`](./skills/poteto-mode/SKILL.md) is the central entry point. It reads your task, selects one of twenty-three playbooks, and coordinates the other skills as steps require:

```text
/poteto-mode this pr has a subtle bug where the scroll drifts every 750ms even when idle. repro first, then fix and verify.
```

```text
/poteto-mode land the stack even if ci flakes. i want everything verified and merged cleanly.
```

### The Twenty-Three Playbooks

| Playbook | Description |
| :--- | :--- |
| [investigation](./skills/poteto-mode/playbooks/investigation.md) | Read-only question: how does X work, why was Y built this way, are we sure. |
| [bug fix](./skills/poteto-mode/playbooks/bug-fix.md) | Reproduce a defect, root-cause it, and fix with runtime evidence. |
| [perf](./skills/poteto-mode/playbooks/perf-issue.md) | Trace a measured slowness and improve it against a baseline. |
| [hillclimb](./skills/poteto-mode/playbooks/hillclimb.md) | Sustained, scientific improvement of one metric against a target. |
| [runtime forensics](./skills/poteto-mode/playbooks/runtime-forensics.md) | Diagnose a live symptom (leak, idle-cpu spin, glitch) from instrumentation. |
| [trace forensics](./skills/poteto-mode/playbooks/trace-forensics.md) | Diagnose a captured profiling artifact (cpuprofile, trace, spindump, heap snapshot). |
| [feature](./skills/poteto-mode/playbooks/feature.md) | New or changed behavior, built from a named data shape. |
| [refactoring](./skills/poteto-mode/playbooks/refactoring.md) | Behavior-preserving change to structure or shape. |
| [prototype](./skills/poteto-mode/playbooks/prototype.md) | Throwaway sketch in an isolated branch workspace to settle an empirical fork. |
| [visual parity](./skills/poteto-mode/playbooks/visual-parity.md) | Pixel-exact UI equivalence between two implementations. |
| [authoring a skill](./skills/poteto-mode/playbooks/authoring-a-skill.md) | Writing or editing a `SKILL.md`. |
| [eval](./skills/poteto-mode/playbooks/eval.md) | Test how a skill or prompt change affects agent behavior, blinded. |
| [babysit](./skills/poteto-mode/playbooks/babysit.md) | Drive a PR or stack to merge-ready: conflicts, review threads, CI. |
| [shipping](./skills/poteto-mode/playbooks/shipping.md) | Independently verify a green stack, then land the contiguous verified run bottom-up. |
| [autonomous run](./skills/poteto-mode/playbooks/autonomous-run.md) | Drive a long task to completion without stopping (Antigravity `/goal`). |
| [orchestrate](./skills/poteto-mode/playbooks/orchestrate.md) | Standing project coordinator: multi-day, many stacked PRs, fleets of subagents. |
| [autopilot-full](./skills/poteto-mode/playbooks/autopilot-full.md) | Independent PRs run to merged with one owner per PR and root swarm verdicts. |
| [autopilot-stack](./skills/poteto-mode/playbooks/autopilot-stack.md) | Build and verify one linear base-branch stack for operator review. |
| [session pickup](./skills/poteto-mode/playbooks/session-pickup.md) | Resume or take over a prior agent's work from an Antigravity transcript or branch. |
| [pause safely](./skills/poteto-mode/playbooks/pause-safely.md) | Suspend in-flight work cleanly so it can be resumed later. |
| [multi-phase plan](./skills/poteto-mode/playbooks/multi-phase-plan.md) | Work that spans phases or stacked PRs. |
| [worktree cleanup](./skills/poteto-mode/playbooks/worktree-cleanup.md) | Reclaim disk by pruning merged/abandoned worktrees and stale caches. |
| [opening a pr](./skills/poteto-mode/playbooks/opening-a-pr.md) | Open a ready PR with conventional commits title and brief body. |

---

## Standalone Skills

Invoke any of the skills directly as slash commands:

| Skill | Use it when |
| :--- | :--- |
| [`/poteto-mode`](./skills/poteto-mode/SKILL.md) | Default entry point for any non-trivial engineering task. |
| [`/architect`](./skills/architect/SKILL.md) | Writing code that crosses boundaries; settle caller usage, types, and module shape first. |
| [`/arena`](./skills/arena/SKILL.md) | Fan out N parallel attempts using `Workspace: 'branch'`, then graft the best ideas. |
| [`/swarm`](./skills/swarm/SKILL.md) | Fan out N parallel workers across matrices or races, then aggregate to one report. |
| [`/interrogate`](./skills/interrogate/SKILL.md) | Multi-perspective adversarial code review (correctness, architecture, code quality). |
| [`/how`](./skills/how/SKILL.md) | Walkthrough and mental model of how a subsystem works. |
| [`/why`](./skills/why/SKILL.md) | Deep investigation into why code was built this way (git blame, PR discussions, MCP tools). |
| [`/recall`](./skills/recall/SKILL.md) | Rebuild working context from conversation transcripts and project history. |
| [`/blast-radius`](./skills/blast-radius/SKILL.md) | Impact analysis: prove what a small-looking change could break. |
| [`/setup-pstack`](./skills/setup-pstack/SKILL.md) | Configure Antigravity model tiers per role. |
| [`/no-comments`](./skills/no-comments/SKILL.md) | Strip unnecessary comments and identify `MUST KILL` refactor targets via Comment Sicko. |
| [`/unslop`](./skills/unslop/SKILL.md) | Clean up writing, removing AI tells and corporate fluff. |
| [`/technical-writing`](./skills/technical-writing/SKILL.md) | Layered documentation standard (Diátaxis + Google dev style). |
| [`/tdd`](./skills/tdd/SKILL.md) | Test-driven bug fixing: failing test first, then fix, then verify. |
| [`/figure-it-out`](./skills/figure-it-out/SKILL.md) | Design a bespoke, rigorous playbook when no bundled playbook fits. |
| [`/show-me-your-work`](./skills/show-me-your-work/SKILL.md) | Log decisions and evidence to an auditable TSV trail. |
| [`/teach`](./skills/teach/SKILL.md) | Weave deep explanations diagram by diagram using Antigravity Artifacts. |
| [`/reflect`](./skills/reflect/SKILL.md) | Mine conversation transcripts for learnings and route them into skill improvements. |
| [`/bro`](./skills/bro/SKILL.md) | Plain-English translation of technical explanations. |
| [`/automate-me`](./skills/automate-me/SKILL.md) | Mine your recent transcripts to draft your own personal `-mode` skill. |
| [`/create-verification-skill`](./skills/create-verification-skill/SKILL.md) | Generate a project-local verification skill with a feature map. |
| [`/maintain-verification-skill`](./skills/maintain-verification-skill/SKILL.md) | Re-align a verification skill's feature map with live code. |
| [`/deslop`](./skills/deslop/SKILL.md) | Remove AI-generated code slop, excessive defensive checks, and unearned abstractions. |
| [`/control-cli`](./skills/control-cli/SKILL.md) | Build or adapt a local harness to drive and verify an interactive CLI with runtime evidence. |
| [`/control-ui`](./skills/control-ui/SKILL.md) | Build or adapt a local Playwright/CDP harness to drive and verify web or desktop UIs. |
| [`/create-skill`](./skills/create-skill/SKILL.md) | Author a new Antigravity skill with standard directory structure and frontmatter. |
| [`/babysit`](./skills/babysit/SKILL.md) | Drive a PR or stack to merge-ready (conflicts, review threads, CI). |
| [`/typescript-best-practices`](./skills/typescript-best-practices/SKILL.md) | Type system discipline grounded in TypeScript syntax. |

---

## Subagents: `poteto-agent` & `comment-sicko`

`agstack` ships definitions for Antigravity subagents:
- **`poteto-agent`** ([agents/poteto-agent.md](./agents/poteto-agent.md)): Full rigorous engineering agent style. Can be defined via `define_subagent(name="poteto-agent", ...)` reading `poteto-mode` in full.
- **`comment-sicko`** ([agents/comment-sicko.md](./agents/comment-sicko.md)): Read-only comment reviewer that savors deletion, removes dead code, and flags workaround code with `MUST KILL`.

---

## The 23 Principles

Every skill and playbook is grounded in twenty-three core principles:

| Principle | Group | Core Rule |
| :--- | :--- | :--- |
| [laziness-protocol](./skills/principle-laziness-protocol/SKILL.md) | Core | Bias toward deletion and the smallest change that solves the problem. |
| [foundational-thinking](./skills/principle-foundational-thinking/SKILL.md) | Core | Model core types and shared state before writing logic. |
| [redesign-from-first-principles](./skills/principle-redesign-from-first-principles/SKILL.md) | Core | Redesign as if the requirement were a foundational assumption from day one. |
| [attack-the-premise](./skills/principle-attack-the-premise/SKILL.md) | Core | Question the shared premise when two or more fixes fail the same gate. |
| [subtract-before-you-add](./skills/principle-subtract-before-you-add/SKILL.md) | Core | Remove dead weight first, then build on the simpler base. |
| [minimize-reader-load](./skills/principle-minimize-reader-load/SKILL.md) | Core | Collapse one-caller wrappers, shrink mutable scope, shorten call chains. |
| [outcome-oriented-execution](./skills/principle-outcome-oriented-execution/SKILL.md) | Core | Converge on the target architecture; do not preserve throwaway compatibility code. |
| [experience-first](./skills/principle-experience-first/SKILL.md) | Core | Choose user delight over implementation convenience. |
| [exhaust-the-design-space](./skills/principle-exhaust-the-design-space/SKILL.md) | Core | Build 2-3 competing prototypes in branch workspaces before committing. |
| [build-the-lever](./skills/principle-build-the-lever/SKILL.md) | Core | Build the tool or test harness that does or proves the work. |
| [model-the-domain](./skills/principle-model-the-domain/SKILL.md) | Architecture | Encode domain logic in typed structures instead of scattered conditionals. |
| [boundary-discipline](./skills/principle-boundary-discipline/SKILL.md) | Architecture | Concentrate validation guards at system boundaries; trust internal types. |
| [type-system-discipline](./skills/principle-type-system-discipline/SKILL.md) | Architecture | Make illegal states unrepresentable; parse external data at boundaries. |
| [make-operations-idempotent](./skills/principle-make-operations-idempotent/SKILL.md) | Architecture | Converge to the same end state regardless of partial prior runs. |
| [migrate-callers-then-delete-legacy-apis](./skills/principle-migrate-callers-then-delete-legacy-apis/SKILL.md) | Architecture | Migrate callers and delete the old API in the same wave. |
| [separate-before-serializing-shared-state](./skills/principle-separate-before-serializing-shared-state/SKILL.md) | Architecture | Eliminate state sharing first; serialize only when strictly invariant. |
| [prove-it-works](./skills/principle-prove-it-works/SKILL.md) | Verification | Verify against the real artifact with runtime proof, not assertions or "it compiles". |
| [fix-root-causes](./skills/principle-fix-root-causes/SKILL.md) | Verification | Trace each symptom to root cause; reproduce first; resist nil-checks. |
| [sequence-verifiable-units](./skills/principle-sequence-verifiable-units/SKILL.md) | Verification | Break work into verifiable units, checking each before starting the next. |
| [test-behavior-not-implementation](./skills/principle-test-behavior-not-implementation/SKILL.md) | Verification | Call code the way users do and assert results against literal expected values. |
| [guard-the-context-window](./skills/principle-guard-the-context-window/SKILL.md) | Delegation | Route bulk output to subagents; keep summaries in the main thread. |
| [never-block-on-the-human](./skills/principle-never-block-on-the-human/SKILL.md) | Delegation | Proceed with reversible actions; reserve questions for irreversible writes. |
| [encode-lessons-in-structure](./skills/principle-encode-lessons-in-structure/SKILL.md) | Meta | Encode repeated instructions as lints, scripts, or runtime checks. |

---

## License

MIT
