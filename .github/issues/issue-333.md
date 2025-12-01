---
id: 333
database_id: 1283518929
node_id: I_kwDOCTsueM5MgPHR
status: closed
title: "git: alias: improve work with stash"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/333
created_at: 2022-06-24T09:40:05Z
updated_at: 2022-07-29T15:20:32Z
---

# git: alias: improve work with stash

**Motivation:** `git stash push --staged` is not presented in the list of aliases

- `git stsh` - `stash --keep-index`
- `git stash` - `git stash push` (Calling git stash without any arguments is equivalent to git stash push)
- `git staash` - `stash --include-untracked`
- `git staaash` - `stash --all`

**To do**

- [x] Make stash call more clear: `stash` -> `stash push`.
- [x] Add optional message: `git stsh some message` -> `git stash push --keep-index -m "some message"`
