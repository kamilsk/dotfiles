---
id: 12
database_id: 421469514
node_id: MDU6SXNzdWU0MjE0Njk1MTQ=
status: closed
title: "extend git stats"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/12
created_at: 2019-03-15T11:16:05Z
updated_at: 2019-03-21T19:49:10Z
---

# extend git stats

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

Customize:
- path
- period
- by author / sum
