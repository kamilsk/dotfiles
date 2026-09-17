---
code: DOT-30
id: 30
database_id: 448421533
node_id: MDU6SXNzdWU0NDg0MjE1MzM=
status: closed
state_reason: completed
milestone:
title: "git it not work properly"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/30
created_at: 2019-05-25T05:26:14Z
updated_at: 2026-09-17T11:05:02Z
---

# git it not work properly

Fix `git it`, the "initialise a repository with an empty root commit" alias. It was defined by delegation to `git cmm`:

`git it -> git cmm root --allow-empty -> git commit -m "$*"` => `root --allow-empty` is a message

Because `cmm` joins every argument into the message ([[DOT-14]]), the `--allow-empty` flag became part of the commit message instead of an option, and the commit failed on an empty tree (or, with staged files, was created with a nonsense message).

Expected: `git it` runs `git init` if needed and creates an empty commit with a fixed message; options are passed to `git commit`, not into the text.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/30#issuecomment-5711695675
Code vs intent: `git-it` runs `git init` *before* computing the date, so a bad offset (#230) leaves a freshly initialised repository behind; harmless on an existing repo, surprising in an empty directory.
-->
