---
code: DOT-4
id: 4
database_id: 391079378
node_id: MDU6SXNzdWUzOTEwNzkzNzg=
status: closed
state_reason: completed
milestone:
title: "add installation entrypoint"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/4
created_at: 2018-12-14T11:47:08Z
updated_at: 2026-09-17T11:09:21Z
---

# add installation entrypoint

Provide a one-line installer that can be pasted into a terminal on a new machine:

```bash
curl -sL https://kamil.samigullin.info/install/dotfiles | bash
```

The point is a short, memorable URL on the author's own domain that redirects to the installation script, so that the bootstrap ([[DOT-3]]) does not start with cloning a repository by hand. The script behind the URL has to work when piped into `bash`, i.e. without a checkout, a TTY or the dotfiles already on `PATH`.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/4#issuecomment-5711703809
Code vs intent: `install` is meant to be piped into `bash`, but line 130 uses a top-level `return 0`, so the "git/curl missing" path aborts with a shell error instead of the friendly message. Line 144 pipes `compaudit` (a zsh function) in a bash script; under `set -euo pipefail` every run ends non-zero. `install-clt` runs before `check`, and its guard (`command -v xcode-select`) is always true on macOS. The SSH clone assumes a GitHub key on a machine that has none yet. Both 2026 reviews list these; none is fixed as of this writing.
-->
