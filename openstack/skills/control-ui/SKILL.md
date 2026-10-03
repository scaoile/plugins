---
name: control-ui
description: Build or adapt a local browser or CDP harness to drive and inspect a web or desktop UI with real runtime evidence. Use for UI verification, screenshots, accessibility snapshots, perf profiles, or visual diffs.
---

# Control UI

Use local browser automation to verify UI behavior with real runtime evidence. First reuse the repo's own Playwright, browser, or Electron harness if it exists; otherwise assemble a temporary local harness around the app's dev server or Chromium debug port.

## What It Is Used For

- Reproducing UI defects that depend on real browser focus, keyboard input, scrolling, resizing, or rendering.
- Verifying visual or accessibility changes with screenshots and DOM snapshots.
- Checking local web, IDE, or Electron behavior before declaring work complete.
- Capturing console logs, network logs, CPU profiles, traces, or heap snapshots.

## Setup Pattern

1. Start the app locally using the repo's documented dev command.
2. Discover existing local harnesses: Playwright tests, Cypress specs, Storybook, browser scripts, or snapshot tools.
3. For a web app, connect to the local URL with headless browser tooling.
4. For Electron/Chromium, enable a remote debugging port (`--remote-debugging-port=<port>`) when supported.
5. Select the correct page by stable app markers, not tab order alone.
6. Prefer accessibility roles, labels, and stable `data-*` selectors over pixel coordinates.

## Generic Web Harness (Playwright)

```javascript
import { chromium } from "playwright";

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1280, height: 800 } });
await page.goto("http://127.0.0.1:<port>");
await page.getByRole("button", { name: /submit/i }).click();
await page.screenshot({ path: "scratch/ui-after.png", fullPage: true });
await browser.close();
```

## Generic CDP Harness (Electron / Chromium)

```javascript
import { chromium } from "playwright";

const browser = await chromium.connectOverCDP("http://127.0.0.1:<debug-port>");
const pages = browser.contexts().flatMap((context) => context.pages());
let page;
for (const candidate of pages) {
  if (await candidate.locator("<app-root-selector>").count()) {
    page = candidate;
    break;
  }
}

if (!page) {
  throw new Error("No matching app page found");
}

await page.screenshot({ path: "scratch/ui-cdp.png", fullPage: true });
await browser.close();
```

## Interaction Loop

1. Capture a page snapshot or screenshot before acting.
2. Choose a target from the latest page structure.
3. Perform exactly one structural action: click, type, keypress, drag, scroll, navigate, or resize.
4. Capture a fresh snapshot/screenshot.
5. Verify the expected state change.
6. Attach screenshots to an Markdown document when presenting proof.

## Guardrails

- Do not rely on stale element references after navigation or DOM updates.
- Avoid coordinate clicks unless necessary.
- Clean up dev servers, debug sessions, and temporary files when done.
