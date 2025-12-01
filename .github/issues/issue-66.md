---
id: 66
database_id: 523843622
node_id: MDU6SXNzdWU1MjM4NDM2MjI=
status: closed
title: "wholisten <port>"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/66
created_at: 2019-11-16T13:12:18Z
updated_at: 2019-11-17T11:28:42Z
---

# wholisten <port>

```bash
$ wholisten # lsof -nP | grep LISTEN
$ wholisten port # lsof -nP -i4TCP:port | grep LISTEN
```
