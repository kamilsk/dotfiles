---
code: DOT-10
id: MDU6SXNzdWU0MDU2NTIxODE=
databaseId: 405652181
number: 10
url: https://github.com/kamilsk/dotfiles/issues/10
title: "add aliases git patch, git minor, git major"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-02-01T10:59:04Z
updatedAt: 2026-09-23T14:19:16Z
lastEditedAt: 2026-09-17T10:56:17Z
closedAt: 2019-03-03T05:57:35Z
---

# add aliases git patch, git minor, git major

Add three aliases that cut a new semantic-version tag from the latest one: `git patch`, `git minor` and `git major` bump the corresponding component of the current release tag and create the tag, so that releasing does not involve reading the last tag and typing the next by hand.

The natural counterpart is `git release` ([git_current](../../bin/git_current) `release`), which already resolves the latest `vX.Y.Z`-style tag; the bump would build on it. Open questions the note leaves: whether the tag is annotated and signed, whether a `v` prefix is kept, and whether the tag is pushed.

<!-- 2019-03-03T05:57Z https://github.com/kamilsk/dotfiles/issues/10#issuecomment-468991998
wont'd
-->

<!-- 2026-09-23T14:19Z https://github.com/kamilsk/dotfiles/issues/10#issuecomment-5796527907
Superseded by #885: `git release --major|--minor|--patch [--rc]` bumps the latest reachable version under one command instead of three aliases.
-->
