---
code: DOT-35
id: MDU6SXNzdWU0NTQyMDMzMjg=
databaseId: 454203328
number: 35
url: https://github.com/kamilsk/dotfiles/issues/35
title: "git start problems at github"
labels:
  - "type: bug"
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-06-10T14:37:04Z
updatedAt: 2026-09-17T11:07:14Z
lastEditedAt: 2026-09-17T11:07:14Z
closedAt: 2019-06-17T19:50:33Z
---

# git start problems at github

Let `git start <id>` resume an issue branch that already exists instead of failing on `checkout -b`. The original output (the Russian git lines mean "Fetching from origin/upstream", "Already up to date", "fatal: a branch named issue-48 already exists"):

```
git start 48
Извлечение из origin
Извлечение из upstream
Уже обновлено.
Current branch master is up to date.
fatal: Ветка с именем «issue-48» уже существует.
done
```

Starting work on an issue is not a one-time act: the branch is left, the trunk is refreshed, and the same `git start 48` is typed again the next day. Expected: if `issue-48` (or exactly one `issue-48-<brief>`) exists, switch to it; if several candidates exist, list them and ask for a more precise name; create the branch only when nothing matches; do not print `done` after a failure.

<!-- 2019-06-14T07:54Z https://github.com/kamilsk/dotfiles/issues/35#issuecomment-502008740
```
git flow github https://github.com/kamilsk/platform
done
 ~/Development/public/platform   master  git start 11 middlewares
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref
no default branch found, see
fatal: empty string is not a valid pathspec. please use . instead if you meant to match all paths
Извлечение из origin
Извлечение из mirror
Уже обновлено.
Current branch master is up to date.
Переключено на новую ветку «issue-11-middlewares»
done
```
-->
