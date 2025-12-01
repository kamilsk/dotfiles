---
id: 398
database_id: 1345266475
node_id: I_kwDOCTsueM5QLyMr
status: open
title: "install: investigate possibilities of osxc"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/398
created_at: 2022-08-20T19:18:55Z
updated_at: 2022-08-20T19:18:56Z
---

# install: investigate possibilities of osxc

**Motivation:** it looks exciting and has interesting techniques, e.g.

```yaml
---
# my mac:
roles:
  - role: dashboard
    disabled: YES
  - role: brew_package
    package_name: node
  - role: cask_package
    package_name: Minecraft
```

**Project:** https://osxc.github.io.

**To do:**

- use [tart](https://github.com/cirruslabs/tart) for integration tests, see related issue
