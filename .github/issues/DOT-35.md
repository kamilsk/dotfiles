---
code: DOT-35
id: 35
database_id: 454203328
node_id: MDU6SXNzdWU0NTQyMDMzMjg=
status: closed
state_reason: completed
milestone:
title: "git start problems at github"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/35
created_at: 2019-06-10T14:37:04Z
updated_at: 2026-09-17T11:07:14Z
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
