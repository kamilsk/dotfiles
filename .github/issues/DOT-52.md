---
code: DOT-52
id: MDU6SXNzdWU0ODQzODU2NzA=
databaseId: 484385670
number: 53
url: https://github.com/kamilsk/dotfiles/issues/53
title: "review brew list"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-08-23T07:58:54Z
updatedAt: 2026-09-17T11:12:02Z
lastEditedAt: 2026-09-17T11:12:02Z
closedAt: 2019-09-13T20:17:10Z
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
