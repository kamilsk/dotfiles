---
code: DOT-81
id: MDU6SXNzdWU2NzEyMDY3NzI=
databaseId: 671206772
number: 82
url: https://github.com/kamilsk/dotfiles/issues/82
title: "truncate logs for docker"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2020-08-01T21:17:50Z
updatedAt: 2026-09-17T11:14:57Z
lastEditedAt: 2026-09-17T11:14:57Z
closedAt: 2020-08-25T06:40:03Z
---

# truncate logs for docker

Add a helper that empties the log file of a running container without restarting it:

`truncate -s 0 $(docker inspect --format='{{.LogPath}}' gateway)`

Docker's default `json-file` driver grows without bound unless `max-size` is configured; for a long-running local container (the example is `gateway`) truncating the file in place is the quickest way to reclaim disk space and to start a clean log before reproducing something.
