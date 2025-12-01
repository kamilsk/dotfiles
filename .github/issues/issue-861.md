---
id: 861
database_id: 4777553967
node_id: I_kwDOCTsueM8AAAABHMOwLw
status: open
title: "bin: notify: gate agent push notifications by presence/intent"
labels: [type: feature, scope: code, impact: medium, effort: medium]
url: https://github.com/kamilsk/dotfiles/issues/861
created_at: 2026-06-30T14:13:39Z
updated_at: 2026-06-30T14:13:39Z
---

**Motivation:** The agent (Claude Code) sends Pushover pushes on its Notification/Stop hooks. I only want them when I'm actually away from the laptop — or when I explicitly asked for them — not while I'm sitting here pairing with the agent. The control state must not clutter `~/.claude` (the agent's dir) and should live in dotfiles as part of the system.

**Interface** (`bin/notify`, on PATH as `notify`):

```bash
notify                 # status: mode, TTL, idle, "would a push fire now?"
notify always [DUR]    # always push (force);  optional auto-expiry
notify never  [DUR]    # never push (silence); optional auto-expiry
notify auto            # default: push only when away (presence-based)
notify run ...         # reserved for #630 (command-timing notifier), not built yet
```

`DUR`: `<n>s|<n>m|<n>h|<n>d` (e.g. `30s`, `15m`, `2h`, `1d`). Away threshold: `NOTIFY_AWAY_AFTER` sec (default 180).

**Model:** three mutually-exclusive modes — `auto | always | never` — stored as a single state field, so contradictory combinations are impossible by construction. `auto` = presence gate: away when idle >= `NOTIFY_AWAY_AFTER` (`ioreg HIDIdleTime`) **or** screensaver/lock active (`pgrep ScreenSaverEngine`). On Apple Silicon, display-sleep / Quartz lock aren't readable — idle covers them. `always`/`never` may carry a TTL and auto-expire back to `auto` (fixes "muted for a call, forgot, missed everything").

**State location:** ephemeral, `${XDG_RUNTIME_DIR:-<DARWIN_USER_TEMP_DIR>}/agent-notify/mode`. Resolved identically — and env-independently, via `getconf` — by both `notify` and the agent hook, so they never disagree even if `$TMPDIR` isn't exported into the hook's environment. Auto-clears on reboot/logout; the trade-off (a reboot silently resets to `auto`) is acceptable and TTL covers staleness. Format: one line `MODE [EXPIRY_EPOCH]`; absent file = `auto`.

**Integration:** the agent hook (`kitchen:agents/scripts/notify-watcher.sh`, wired to Claude Code Notification/Stop hooks) reads the same state: `never` -> skip, `always` -> send, `auto` -> presence gate. Replaces the previous `~/.claude/notify.{force,mute}` flag files + zsh `afk/back/mute/unmute` aliases (both removed).

**Relationship to #630:** `notify` becomes a subcommand dispatcher; #630's "notify if a run is longer than X sec" becomes the reserved `notify run` subcommand.

**Out of scope:**

- managing `NOTIFY_AWAY_AFTER` via the CLI (env/default for now);
- Focus/DND integration;
- non-macOS presence detection;
- implementing `notify run` (tracked by #630).

