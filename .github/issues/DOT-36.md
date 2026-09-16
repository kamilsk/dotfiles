---
code: DOT-36
id: 36
database_id: 457126131
node_id: MDU6SXNzdWU0NTcxMjYxMzE=
status: closed
title: "add mirror"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/36
created_at: 2019-06-17T20:10:02Z
updated_at: 2026-09-17T11:07:40Z
---

# add mirror

Add a `git mirror` command that registers a Bitbucket copy of the current GitHub repository as a `mirror` remote. The author kept mirrors "at bitbucket" (the whole note) so that the same branches could be pushed to both hostings; the early `progress` alias already force-pushed to a remote named `mirror` ([#1](DOT-1.md)), and this command is the piece that creates that remote.

Expected: `git mirror <url>` adds the `mirror` remote, or updates its URL when it exists; later, `git mirror` without arguments derives the URL from `origin` ([#48](DOT-47.md)). Pushing to the mirror is left to `push` / `git please`, which iterate over every remote except `upstream` and `fork-*`.

<!-- 2019-06-17T20:14Z https://github.com/kamilsk/dotfiles/issues/36#issuecomment-502833667
done https://bitbucket.org/kamilsk/dotfiles/src/master/
-->

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/36#issuecomment-5711701806
Note: `alias.mirror` is legacy-only (see the note on #359); `git_mirror` also only understands `git@github.com` origins.
-->
