---
code: DOT-10
id: 10
database_id: 405652181
node_id: MDU6SXNzdWU0MDU2NTIxODE=
status: closed
title: "add aliases git patch, git minor, git major"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/10
created_at: 2019-02-01T10:59:04Z
updated_at: 2026-09-17T10:56:17Z
---

# add aliases git patch, git minor, git major

Add three aliases that cut a new semantic-version tag from the latest one: `git patch`, `git minor` and `git major` bump the corresponding component of the current release tag and create the tag, so that releasing does not involve reading the last tag and typing the next by hand.

The natural counterpart is `git release` ([git_current](../../bin/git_current) `release`), which already resolves the latest `vX.Y.Z`-style tag; the bump would build on it. Open questions the note leaves: whether the tag is annotated and signed, whether a `v` prefix is kept, and whether the tag is pushed.

<!-- 2019-03-03T05:57Z https://github.com/kamilsk/dotfiles/issues/10#issuecomment-468991998
wont'd
-->
