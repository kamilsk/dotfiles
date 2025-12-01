---
id: 82
database_id: 671206772
node_id: MDU6SXNzdWU2NzEyMDY3NzI=
status: closed
title: "truncate logs for docker"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/82
created_at: 2020-08-01T21:17:50Z
updated_at: 2020-08-25T06:40:03Z
---

# truncate logs for docker

`truncate -s 0 $(docker inspect --format='{{.LogPath}}' gateway)`
