---
code: DOT-54
id: 55
database_id: 487790629
node_id: MDU6SXNzdWU0ODc3OTA2Mjk=
status: closed
title: "git refresh works not well"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/55
created_at: 2019-08-31T17:06:44Z
updated_at: 2026-09-17T11:12:23Z
---

# git refresh works not well

Make `git refresh <remote> <branch>` rebase onto the branch that was named, not onto the current branch's name at that remote. The original transcript, from a loop over `fork-*` checkouts ("Извлечение из" = "Fetching from"; the block repeated for every fork):

```bash
for fork in $(ls | grep fork-); do (cd $fork; git refresh upstream master; g^); done
Извлечение из origin
Извлечение из upstream
fatal: invalid upstream 'upstream/research'
done
Everything up-to-date
```

The forks were on a local `research` branch, and `git refresh upstream master` tried to rebase onto `upstream/research`: the second argument was ignored and the current branch name used instead, so the target did not exist at upstream and nothing was rebased, after which `g^` pushed the unchanged branch ("Everything up-to-date") and the loop reported `done` as if it had worked.

Expected: the second argument names the remote branch to rebase onto; without it, the remote's default branch is used ([#16](DOT-16.md)); a failed rebase fails the command, so that a chained push does not run.

<!-- 2019-09-01T18:05Z https://github.com/kamilsk/dotfiles/issues/55#issuecomment-526940804
fixed
-->
