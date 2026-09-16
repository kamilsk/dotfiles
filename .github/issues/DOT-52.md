---
code: DOT-52
id: 53
database_id: 484385670
node_id: MDU6SXNzdWU0ODQzODU2NzA=
status: closed
title: "review brew list"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/53
created_at: 2019-08-23T07:58:54Z
updated_at: 2026-09-17T11:12:02Z
---

# review brew list

Reconcile the installed Homebrew formulae with the list the installer maintains. The note points at the package list then embedded in `install.sh` (lines 38–54) and pastes `brew list | cat` — about eighty names, most of them transitive dependencies (`apr`, `brotli`, `gdbm`, `icu4c`, `jansson`, `libev`, …) next to the tools actually wanted (`ansible`, `bat`, `composer`, `git`, `go`, `httpie`, `jq`, `kubernetes-cli`, `node`, `php`, `python`, `zsh`, …).

The intent is to decide, per formula, whether it is a deliberate dependency of the setup or an accident of `brew install`, keep only the former in the declared list, and let Homebrew manage the rest.

<!-- 2019-08-23T08:02Z https://github.com/kamilsk/dotfiles/issues/53#issuecomment-524216065
`brew install protobuf` is important
-->

<!-- 2019-09-13T15:05Z https://github.com/kamilsk/dotfiles/issues/53#issuecomment-531274511
`https://formulae.brew.sh/formula/%s` to print all list and open it in a browser
-->
