---
name: interrogate
description: Run an adversarial multi-perspective review on code changes. Use for /interrogate, 'adversarial review', 'multi-model review', 'challenge this', 'stress test this code', 'find blind spots', or 'tear this apart'.
---

# Interrogate

Spawn multiple adversarial reviewers across independent lenses to rigorously review code changes. Each reviewer gets the same changeset and rubric. The adversarial signal comes from diverse lenses and independent execution.

The deliverable is a synthesized verdict. Do NOT auto-apply changes.

## Step 1. Determine Scope

Identify what to review from context:
- If the user points at specific files or a diff, use that.
- If on a feature branch, run `git diff main...HEAD` (or appropriate base branch) for the full changeset.
- Package the diff plus any surrounding context files needed to understand the code.

## Step 2. State the Intent

Before spawning reviewers, state the intent explicitly:
- Summarize what the change aims to do in one clear paragraph.
- If unsure about the intent, clarify with the user before proceeding.

## Step 3. Spawn Reviewers

Launch all reviewers in a single `invoke_subagent` call with `Subagents: [...]`:

- **Reviewer A** (`Model: "pro"`, `TypeName: "research"`, `Role: "Correctness Reviewer"`): Focuses on logic errors, concurrency, edge cases, state leaks, and invariant violations.
- **Reviewer B** (`Model: "pro"`, `TypeName: "research"`, `Role: "Architecture Reviewer"`): Focuses on domain modeling, boundary discipline, API contracts, and unearned abstractions.
- **Reviewer C** (`Model: "flash"`, `TypeName: "research"`, `Role: "Code Quality Reviewer"`): Focuses on comment hygiene, dead code, test coverage adequacy, and style discipline.

Read `references/reviewer-prompt.md` and fill in the template with:
1. The stated intent
2. The diff or file contents
3. The review rubric from `references/rubric.md`
4. The code-quality lens from `references/code-quality-review.md`

All reviewers receive the filled template to examine from their designated focus angle.

## Step 4. Synthesize

Antigravity wakes up the lead reviewer automatically upon completion.
1. **Parse all findings** from reviewers.
2. **Identify consensus**: Findings raised by 2+ reviewers independently carry the highest signal.
3. **Identify lone-model findings**: Valuable edge catches, weighted accordingly.
4. **Deduplicate**: Merge overlapping findings into single clear issues.
5. **Note disagreements**: Contrasting assessments provide key context for lead judgment.

## Step 5. Lead Judgment

You are the lead reviewer—a pragmatic senior engineer, not a neutral aggregator. Read `references/lead-judgment.md` for the full framework.

Categorize every finding:
- **Act on**: Real defects affecting correctness, security, or maintainability. These would block a PR.
- **Consider**: Legitimate improvements, but balanced against cost. Worth user attention.
- **Noted**: Valid observations, but premature or low-impact for the current stage.
- **Dismissed**: False alarms, nitpicks, or missing context. Brief explanation why.

## Output Format

Present the final verdict as an Antigravity Markdown Artifact (`write_to_file` with `ArtifactMetadata`), using this structure:

### Intent
> [Stated intent paragraph]

### Reviewers
- Reviewer A (Correctness, Pro): [N findings]
- Reviewer B (Architecture, Pro): [N findings]
- Reviewer C (Quality, Flash): [N findings]

### Act On
[Blocking findings with rationale and line pointers]

### Consider
[Non-blocking improvements]

### Noted & Dismissed
[Summary of low-impact or rejected findings]
