---
name: control-cli
description: Build or adapt a local harness to drive, inspect, and profile an interactive CLI or TUI with real runtime evidence. Use for CLI UX checks, startup regressions, memory leaks, hangs, or prompt flows.
---

# Control CLI

Use a repeatable local harness to exercise an interactive CLI instead of manual ad-hoc testing. First reuse the repo's own test or demo harness if it exists; otherwise assemble a temporary harness from standard local tools.

## What It Is Used For

- Reproducing CLI/TUI bugs with deterministic input.
- Verifying keyboard flows, prompts, interrupts, resize behavior, and terminal layout.
- Capturing before/after transcripts for bug fixes.
- Profiling startup time, slow operations, hangs, or memory growth.
- Recording terminal output to provide concrete proof of functionality.

## Harness Loop

1. Identify the command under test and the smallest reproducible workspace.
2. Discover existing local harnesses: package scripts, e2e tests, demo recorders, expect scripts, or PTY helpers.
3. If no harness exists, launch the CLI in an isolated terminal session with deterministic environment variables.
4. Capture the current screen before interacting.
5. Send one action at a time: text, Enter, arrows, Escape, Ctrl-C, resize.
6. Wait for a concrete screen pattern or prompt before the next action.
7. Save the transcript and any profile artifacts.
8. Kill the session cleanly.

## Harness Options

- **Repo-native harness**: Prefer checked-in scripts because they know the app's startup, environment, and prompts.
- **`tmux`**: Managed sessions, `capture-pane`, `send-keys`, attach/detach.
- **PTY probe**: Use a short Python or Node script when tmux is unavailable.
- **Runtime inspector**: Use Node or Bun inspector for CPU profiles, heap snapshots, and live evaluation.

## Minimal tmux Harness

```bash
SESSION="cli-harness-$(date +%s)"
tmux new-session -d -s "$SESSION" -- <command-under-test>
tmux capture-pane -pt "$SESSION"
tmux send-keys -t "$SESSION" "help" Enter
tmux capture-pane -pt "$SESSION"
tmux kill-session -t "$SESSION"
```

## Minimal Python PTY Harness

```python
import os, pty, select, subprocess, time

master_fd, slave_fd = pty.openpty()
proc = subprocess.Popen(
    ["<command>", "<arg>"],
    stdin=slave_fd,
    stdout=slave_fd,
    stderr=slave_fd,
    close_fds=True,
)
os.close(slave_fd)

deadline = time.time() + 30
buffer = b""
while time.time() < deadline:
    ready, _, _ = select.select([master_fd], [], [], 0.25)
    if not ready:
        continue
    chunk = os.read(master_fd, 4096)
    buffer += chunk
    if b"<ready text>" in buffer:
        os.write(master_fd, b"help\n")
        break

print(buffer.decode(errors="replace"))
proc.terminate()
os.close(master_fd)
```

## Guardrails

- Prefer deterministic waits over sleep delays.
- Do not send credentials or destructive commands into a controlled session.
- Clean up processes, temp files, and sessions after completion.
