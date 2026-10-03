---
name: swarm
description: Fan out N parallel workers, aggregate their results, and return one consolidated report. Use for /swarm, 'swarm this', or parallel coverage matrices, test races, gauntlets, and exploration.
---

# Swarm

Fan out N parallel workers. They may cover separate slices, race the same brief, or mix both. The parent aggregates results and returns one unified report.

## Start

Open a todolist with one entry per phase before launching anything:

1. Frame
2. Fan out
3. Aggregate
4. Report

## Phase A: Frame

1. State the done predicate and the artifact or report the swarm must return.
2. Choose the shape: partition into slices, race N workers on identical briefs, or mix both. For a race or mixed shape, declare `first pass`, `rank all`, or `best-of` before spawning.
3. Set N from the user or derive it from the shape.
4. Pick the worker model tier. Use `Model: "flash"` for fast parallel execution, test coverage, and searches. Use `Model: "pro"` for complex reasoning or judgment. Use `Model: "inherit"` to match the parent agent.
5. Give each worker its own writable output or isolated branch workspace (`Workspace: 'branch'`) when it writes. When workers verify or measure commits, each brief names the exact SHAs and measurement method.

## Phase B: Fan out

Spawn all N workers in a single `invoke_subagent` tool call with the `Subagents: [...]` array.
- `TypeName`: `"research"` for read-only tasks, or `"self"` / `"poteto-agent"` for code edits.
- `Model`: the configured model tier from Step 4.
- `Workspace`: `"branch"` if writing code, `"inherit"` if reading.

Every brief stands alone. Include the goal, scope, exact slice or race arm, how to verify, and what to report. Reports use `PASS`, `ISSUES`, or `BLOCKED` with concrete evidence. A worker that proves a defect reports `ISSUES` and lists every issue it can prove, not only the first.

If a worker drops out or fails, proceed with N-1 and note it.

## Phase C: Aggregate

OpenCode wakes up the parent automatically when subagents complete.

Read the terminal results. Drop a result that does not record the SHAs and method its brief names, and rerun that worker once. After a second miss, record a gap. A gap does not count as a pass. For coverage, every required slice needs a result. For a race, apply the selection rule declared up front. Do not paste raw worker dumps into chat.

Keep a compact result table, one-line evidenced issues, and explicit gaps or dropouts.

## Phase D: Report

Return one consolidated report with the result table, issue one-liners, gaps or dropouts, and the race rule when used. If the report is extensive, save it as an Markdown report.
