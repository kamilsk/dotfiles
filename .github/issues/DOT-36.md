---
code: DOT-36
id: MDU6SXNzdWU0NTcxMjYxMzE=
databaseId: 457126131
number: 36
url: https://github.com/kamilsk/dotfiles/issues/36
title: "add mirror"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-06-17T20:10:02Z
updatedAt: 2026-09-17T11:07:40Z
lastEditedAt: 2026-09-17T11:07:40Z
closedAt: 2019-06-17T20:14:09Z
---

# add mirror

Add a `git mirror` command that registers a Bitbucket copy of the current GitHub repository as a `mirror` remote. The author kept mirrors "at bitbucket" (the whole note) so that the same branches could be pushed to both hostings; the early `progress` alias already force-pushed to a remote named `mirror` ([[DOT-1]]), and this command is the piece that creates that remote.

Expected: `git mirror <url>` adds the `mirror` remote, or updates its URL when it exists; later, `git mirror` without arguments derives the URL from `origin` ([[DOT-47]]). Pushing to the mirror is left to `push` / `git please`, which iterate over every remote except `upstream` and `fork-*`.

<!-- 2019-06-17T20:14Z https://github.com/kamilsk/dotfiles/issues/36#issuecomment-502833667
done https://bitbucket.org/kamilsk/dotfiles/src/master/
-->

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/36#issuecomment-5711701806
Note: `alias.mirror` is legacy-only (see the note on #359); `git_mirror` also only understands `git@github.com` origins.
-->
