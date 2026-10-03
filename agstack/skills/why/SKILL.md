---
name: why
description: Investigate the historical motivation, intent, and tradeoffs behind code. Use for 'why does X work this way', 'why we picked Y', design rationale, regressions, postmortems, or data-backed thresholds. Queries available evidence categories (source control, issue tracker, docs, observability, error tracking) in parallel, then returns a cited report. Use /how for runtime behavior.
---

# Why

Investigate the motivation and intent behind code.

Companion to the `how` skill (`/how`). `how` answers what the code does and how it works. `why` answers what forces led to its shape.

## Operating Posture

Operate as a **careful, cautious, and precise investigator**. Be honest about what you know vs what you're inferring. Read `references/epistemics.md` for the full confidence framework and phrasing guide. The synthesizer must follow it.

## Step 1. Understand the Target and the Question

Parse what the user is asking. The **target** is usually a chunk of code, a pattern, a feature, or a named design decision. The **question** is usually a design rationale, a tradeoff, a motivating edge case, an external constraint, dead code, or a broad history sweep.

If the target is vague, make your best inference from conversation context. State your interpretation briefly so the user can redirect if you're off, then proceed.

## Step 2. Establish the Code Anchor

Before spawning investigators, anchor the investigation in concrete code:
- The relevant file path(s) and line range(s).
- The key symbols (function names, class names, constants).
- An initial commit list: the last few commits touching the target.
- PR numbers from merge commits (pattern `(#1234)` in the subject line).

Build this inline:

```bash
# Blame target lines for last-touch commits
git blame -L <start>,<end> <file>

# Full file history, with patches, through renames
git log --follow -p -- <file>

# Last N commits touching the file, PR numbers visible
git log --oneline -20 -- <file>

# Extract PR numbers from a commit message
git log -1 --format=%B <commit>
```

Pull PR bodies and discussion via `gh` for any substantive commits:

```bash
gh pr view <number> --json title,body,author,createdAt,mergedAt,labels,closingIssuesReferences,comments,reviews
```

Capture this as seed context (file paths, symbols, commits, PR numbers, linked ticket IDs). Pass it to the investigators.

## Step 3. Spawn Parallel Investigators

### Discovery

Before spawning investigators, inspect available tools and MCP servers (from Antigravity `mcp_config.json` or active tool providers).

Map each available source to an evidence category:
1. **Source control history** (Git, `gh`, code comments, tests)
2. **Issue / ticket tracker** (Linear, Jira, GitHub Issues)
3. **Long-form documents** (Notion, Google Docs, Confluence)
4. **Real-time team chat** (Slack, Discord)
5. **Infrastructure observability** (Datadog, Grafana)
6. **Error / exception tracking** (Sentry, Bugsnag)
7. **Product analytics warehouse** (BigQuery, Snowflake)

Source control is always available through git and `gh`. For the others, activate investigators based on available tools.

Launch all matching investigators in a single `invoke_subagent` call with `Subagents: [...]`:
- `TypeName`: `"research"`
- `Model`: `"flash"`
- `Role`: `"<Category> Investigator"`

Each investigator gets:
1. The base prompt from `references/investigator-prompt.md`
2. The category playbook `references/sources/<source>.md`
3. The cross-cutting `references/sources/incident-postmortem.md` if the target code looks defensive (null checks, retry logic, timeout handling, rate limiting)
4. The code anchor from Step 2
5. The user's original question

## Step 4. Synthesize Findings

Antigravity resumes automatically when all investigators report back. Synthesize using `Model: "pro"`:

1. **Verify citations**: Trace each claim to an exact commit, PR discussion, issue, or doc URL.
2. **Apply epistemic tags**: Label every statement as `[Observed]`, `[Inferred]`, or `[Speculative]`.
3. **Identify constraints**: Extract what assumptions governed the original decision and whether those assumptions still hold.

## Step 5. Present the Investigation

Save the findings as an Antigravity Markdown Artifact (`write_to_file` with `ArtifactMetadata`), structured with:
- **Core Motivation**: The primary forcing function that created the design.
- **Historical Context & PR Discussion**: Quotes, commit SHAs, and architectural debates.
- **Tradeoffs Accepted**: What alternatives were considered and why they were rejected.
- **Current Relevance**: Does the original motivation still apply today?
- **Sources Consulted**: Full list of tools/MCPs checked and any skipped categories.
