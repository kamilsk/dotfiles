---
code: DOT-81
id: 82
database_id: 671206772
node_id: MDU6SXNzdWU2NzEyMDY3NzI=
status: closed
title: "truncate logs for docker"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/82
created_at: 2020-08-01T21:17:50Z
updated_at: 2026-09-17T11:14:57Z
---

# truncate logs for docker

Add a helper that empties the log file of a running container without restarting it:

`truncate -s 0 $(docker inspect --format='{{.LogPath}}' gateway)`

Docker's default `json-file` driver grows without bound unless `max-size` is configured; for a long-running local container (the example is `gateway`) truncating the file in place is the quickest way to reclaim disk space and to start a clean log before reproducing something.
