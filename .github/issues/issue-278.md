---
id: 278
database_id: 1193533742
node_id: I_kwDOCTsueM5HI-Eu
status: closed
title: "self-update (npm|go|php) or update (npm|go|php)"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/278
created_at: 2022-04-05T17:57:43Z
updated_at: 2022-04-14T15:09:36Z
---

# self-update (npm|go|php) or update (npm|go|php)

```bash
$ update npm

function update() {
  local packages=("${@}")
  if [ ${#packages[@]} = 0 ]; then
    IFS=' ' read -r -a packages <<<"$(npm ls --depth=0 --prod --json |
      jq -r '.dependencies | keys | join(" ")')"
  fi
  for pkg in "${packages[@]}"; do
    npm install "${pkg}"@latest
  done
}
```
