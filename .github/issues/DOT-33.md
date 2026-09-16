---
code: DOT-33
id: 33
database_id: 451926177
node_id: MDU6SXNzdWU0NTE5MjYxNzc=
status: closed
title: "git shake problems"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/33
created_at: 2019-06-04T10:47:46Z
updated_at: 2026-09-17T11:06:21Z
---

# git shake problems

Make `git shake` work in a clone whose remote has no `HEAD` symbolic ref. The original output (the Russian git lines mean "Fetching from origin", "Already on master", "Your branch is up to date with origin/master"):

```
git shake
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref
no default branch found, see
fatal: empty string is not a valid pathspec. please use . instead if you meant to match all paths
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref
no default branch found, see
Извлечение из origin
fatal: invalid upstream 'origin/'
done
Уже на «master»
Ваша ветка обновлена в соответствии с «origin/master».
```

**Cause:** `git default` resolved the trunk from `refs/remotes/origin/HEAD`, which exists only when the clone was made by `git clone` or `git remote set-head` was run; in a repository whose remote was added by hand it is absent, the result is empty, and every consumer went on with an empty branch name: `git checkout ""`, `git rebase origin/`. The ticked item "check on private/workshops" names the repository where the fix was verified.

Expected: when the remote HEAD is unknown, the default branch is resolved by asking the remote instead of assumed empty, and a failure to resolve stops the sweep before any checkout or deletion.
