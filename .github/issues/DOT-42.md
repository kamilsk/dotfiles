---
code: DOT-42
id: MDU6SXNzdWU0NjE5NDk5NjU=
databaseId: 461949965
number: 43
url: https://github.com/kamilsk/dotfiles/issues/43
title: "stash undo|rollback"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-06-28T09:42:31Z
updatedAt: 2026-09-17T11:10:10Z
lastEditedAt: 2026-09-17T11:10:10Z
closedAt: 2019-07-13T12:38:20Z
---

# stash undo|rollback

Add an `undo` (or `rollback`) subcommand to the `stash` command recorder ([[DOT-37]]) that removes the last recorded command from the stash. A command is appended only when it succeeds, but "succeeded" is not the same as "worth replaying" — a `ls` typed out of curiosity, or a step that turned out to be unnecessary, should be droppable without clearing the whole sequence with `drop` and starting over.

The expected behaviour is that `stash undo` deletes the last line of the recorded script and leaves the rest intact; repeated calls walk back further. Whether the removed command is printed, and whether an empty stash is an error, was not specified.

<!-- 2019-07-13T12:38Z https://github.com/kamilsk/dotfiles/issues/43#issuecomment-511118982
moved to kamilsk/stash/issues/3
-->
