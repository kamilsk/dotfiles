---
code: DOT-26
id: 26
database_id: 444798512
node_id: MDU6SXNzdWU0NDQ3OTg1MTI=
status: closed
title: "add git detach alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/26
created_at: 2019-05-16T07:34:25Z
updated_at: 2019-06-18T19:31:39Z
---

# add git detach alias

Add a `git detach` alias that removes a release tag everywhere: locally and on the remote, in one command. The sketch also wanted a `current` form for the tag on `HEAD`:

```bash
$ git detach 0.0.2 || git detach current
> git tag -d 0.0.2
> git push <remote> :refs/tags/0.0.2
```

The motivation is the release flow: a tag cut by mistake, or pushed to the mirror as well as to `origin`, has to be deleted from every remote, and typing the `:refs/tags/…` push per remote is error-prone.

<!-- 2019-06-18T19:31Z https://github.com/kamilsk/dotfiles/issues/26#issuecomment-503278927
implemented by #34
-->
