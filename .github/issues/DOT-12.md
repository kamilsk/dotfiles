---
code: DOT-12
id: 12
database_id: 421469514
node_id: MDU6SXNzdWU0MjE0Njk1MTQ=
status: closed
state_reason: completed
milestone:
title: "extend git stats"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/12
created_at: 2019-03-15T11:16:05Z
updated_at: 2026-09-17T10:57:09Z
---

# extend git stats

Turn a pair of one-liners into a `git stats` command that reports, per author, how many lines were added, removed and remain in the current directory of the repository. The original scripts:

```
git shortlog -s -- $(pwd) | cut -c8- | while read i
do
    git log --author="$i" --pretty=tformat: --numstat -- $(pwd) ":!vendor"  \
    | awk -v name="$i" '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "%s: added lines: %s, removed lines: %s, total lines: %s\n", name, add, subs, loc }'
done
```

```
git shortlog -s --since=1.month -- $(pwd) | cut -c8- | while read i
do
    git log --author="$i" --pretty=tformat: --numstat -- $(pwd) \
    | awk -v name="$i" '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "%s: added lines: %s, removed lines: %s, total lines: %s\n", name, add, subs, loc }'
done
```

The customisation the author wanted: the path (current directory versus the whole repository), the period (`--since=…`) and the grouping (per author or a single sum).

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/12#issuecomment-5711680044
Note: `alias.stats` (and `day`/`week`/`month`) are legacy-only, see the note on #359; the script works as `git_stats`.
-->
