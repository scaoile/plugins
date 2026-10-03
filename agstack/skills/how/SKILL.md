---
name: how
description: Explain subsystem architecture, runtime flow, and mental models. Use for 'how does X work', code walkthroughs before changing something, and placement or layering questions ('where should this live', 'which package owns this'). Use /why for historical motivation.
---

# How

Explore the codebase to answer "how does X work?" questions. Produce architectural explanations at the level of a senior engineer onboarding onto a subsystem—enough to build a working mental model, without reading like annotated source code.

## Step 1. Assess Complexity

If the scope is ambiguous, state your interpretation and explore. The user can redirect.

- **Simple** (a single module, a small utility, a narrow question such as "how does function X work"): no explorers. One explainer explores and explains in a single pass. Go to Step 2b.
- **Complex** (a subsystem spanning multiple files or services, a cross-cutting feature, a full architectural overview): spawn parallel explorers first, then hand off to the explainer. Go to Step 2a.

When in doubt, take the simple path.

## Step 2a. Explore (complex questions only)

Decompose the question into 2 to 4 exploration angles, each a distinct slice of the subsystem. Spawn all explorers in a single `invoke_subagent` tool call:

- `TypeName`: `"research"`
- `Model`: `"flash"`
- `Role`: `"Subsystem Explorer"`

Each explorer gets the prompt in `references/explorer-prompt.md` with its angle filled in. Then go to Step 3.

## Step 2b. Direct Explain (simple questions)

Explore and explain in one pass, using `Model: "pro"` (or directly in the lead agent):
- Gather key symbols and call chains.
- Build the explanation using the structure in `references/explainer-prompt.md`. Go to Step 4.

## Step 3. Synthesize (complex questions only)

Once all explorers have returned, synthesize findings into a single coherent explanation using `Model: "pro"` (via `invoke_subagent` or lead agent synthesis):
- Combine the explorer reports.
- Resolve any conflicting observations.
- Build the final explanation following `references/explainer-prompt.md`.

## Step 4. Present

Present the explanation to the user. If extensive or containing diagrams, save as an Antigravity Markdown Artifact (`write_to_file` with `ArtifactMetadata`).

## Output Format

The explanation uses these sections (omitting any that do not apply):
1. **Overview**
2. **Key Concepts**
3. **How It Works**
4. **Where Things Live**
5. **Gotchas & Invariants**
