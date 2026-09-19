---
code: DOT-34
id: MDU6SXNzdWU0NTM3NzgxNTc=
databaseId: 453778157
number: 34
url: https://github.com/kamilsk/dotfiles/issues/34
title: "git untag"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-06-08T10:05:12Z
updatedAt: 2026-09-17T11:06:48Z
lastEditedAt: 2026-09-17T11:06:48Z
closedAt: 2019-06-14T17:15:23Z
---

# git untag

Add `git untag <tag>`: delete a tag locally and on every remote that has it.

```bash
$ git untag 0.x.y

$ git tag -d 0.x.y
$ for remote in $remotes; do git push $remotes :refs/tags/$tag; done
```

This is the same need as [[DOT-26]] (`git detach`) under the name that stuck: with a `mirror` remote next to `origin`, a wrongly cut release has to be removed from both, and the push-deletion syntax is easy to get wrong.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/34#issuecomment-5711697755
See the note on #168 on the stale `/tmp` cache of remote tags. The `untag` alias itself is legacy-only; on a fresh setup only `git_untag` (script name) works.
-->
