---
code: DOT-37
id: 38
database_id: 457969304
node_id: MDU6SXNzdWU0NTc5NjkzMDQ=
status: closed
title: "stash prototype"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/38
created_at: 2019-06-19T11:55:06Z
updated_at: 2019-06-19T11:56:02Z
---

# stash prototype

Build a command recorder called `stash`: every command run through it is executed immediately and, if it succeeds, appended to a personal script, so that the same sequence can be replayed later in another directory. The use case in the sketch is a routine done in one Go project — update a dependency, commit — that has to be repeated in the next one:

```bash
$ stash git pull
$ stash git checkout -b some branch
$ stash go get -u package
$ stash git add .
$ stash git cmm update package dep
$ cd /other/project
$ stash flush|repeat
```

`repeat` replays the recorded script and keeps it; `flush` replays it and empties it. A command that fails must not be recorded, so the script only ever contains a sequence that worked once. The name is unrelated to `git stash`: it is a standalone shell command.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/38#issuecomment-5711702790
Note: `bin/legacy/stash` is archival — `bin/legacy` is not on `PATH` — and its header still lists the unchecked feature wishes (multiple stashes, renaming, pipes, the `cd` case), so the prototype was frozen rather than finished.
-->
