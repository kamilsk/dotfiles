---
code: DOT-34
id: 34
database_id: 453778157
node_id: MDU6SXNzdWU0NTM3NzgxNTc=
status: closed
title: "git untag"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/34
created_at: 2019-06-08T10:05:12Z
updated_at: 2019-06-14T17:15:23Z
---

# git untag

Add `git untag <tag>`: delete a tag locally and on every remote that has it.

```bash
$ git untag 0.x.y

$ git tag -d 0.x.y
$ for remote in $remotes; do git push $remotes :refs/tags/$tag; done
```

This is the same need as [#26](DOT-26.md) (`git detach`) under the name that stuck: with a `mirror` remote next to `origin`, a wrongly cut release has to be removed from both, and the push-deletion syntax is easy to get wrong.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/34#issuecomment-5711697755
See the note on #168 on the stale `/tmp` cache of remote tags. The `untag` alias itself is legacy-only; on a fresh setup only `git_untag` (script name) works.
-->
