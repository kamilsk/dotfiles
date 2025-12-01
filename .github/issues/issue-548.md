---
id: 548
database_id: 1645136390
node_id: I_kwDOCTsueM5iDsoG
status: closed
title: "env: refactor PATH"
labels: [type: improvement, scope: code, impact: high, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/548
created_at: 2023-03-29T06:46:05Z
updated_at: 2023-03-29T12:58:29Z
---

# env: refactor PATH

**Motivation:** I need to overwrite some binaries, e.g., maintainer, by local installation.

Also, review the script https://raw.githubusercontent.com/Homebrew/install/master/install.sh.

**Target**

```bash
export PATH="${_hack}:${_bins}:${_brew}:${PATH}"
```

https://github.com/kamilsk/dotfiles/blob/cd9a348d7239c120b82fd7896caf12d692129e29/bin/lib/env.bash#L7
