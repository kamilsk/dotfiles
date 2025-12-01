---
id: 138
database_id: 844348232
node_id: MDU6SXNzdWU4NDQzNDgyMzI=
status: open
title: "update policy to work with remotes"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/138
created_at: 2021-03-30T10:34:48Z
updated_at: 2022-08-14T18:54:16Z
---

# update policy to work with remotes

mirror

```bash
$ git mirror git@some.mirror
> git remote -v | grep mirror
> if not: git remote add mirror git@some.mirror
> if present: git remote -v | grep mirror | grep git@some.mirror
> if not: git remote set-url --add --push git@some.mirror
```

fork, aka upstream

```bash
$ git upstream git@some.mirror
> git remote -v | grep upstream
> if not: git remote add upstream --mirror=fetch git@some.mirror
> if present: git remote -v | grep upstream | grep git@some.mirror
> if not: git remote set-url --add git@some.mirror
```

after this change I can remove `grep` hack from `push` command
