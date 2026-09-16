---
code: DOT-66
id: 67
database_id: 527712966
node_id: MDU6SXNzdWU1Mjc3MTI5NjY=
status: closed
title: "oom alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/67
created_at: 2019-11-24T15:18:38Z
updated_at: 2026-09-17T11:13:57Z
---

# oom alias

Add an `oom` alias that shows the kernel log lines about memory pressure and the out-of-memory killer, so that a process that vanished on a Linux box can be checked in one command. The original body is the definition:

```
sudo journalctl -k | grep -i -e memory -e oom
```

It reads the kernel ring buffer through `journalctl -k` and keeps the lines mentioning memory or OOM; it is a Linux (systemd) tool, so the alias only makes sense where `journalctl` exists — for the author presumably remote servers rather than the Mac.

<!-- 2026-09-17T08:42Z https://github.com/kamilsk/dotfiles/issues/67#issuecomment-5711715068
Code vs intent: `bin/lib/aliases.bash:62` defines `oom` inside `if ! command -v journalctl`, i.e. only when `journalctl` is *absent* — on macOS, where the alias cannot work — and skips it on hosts that have the command. The neighbouring guards in the same file (`sublime`, `code`) use the negated form legitimately, which is probably where the pattern came from. No macOS equivalent (reading `log show` for jetsam events) is provided.
-->
