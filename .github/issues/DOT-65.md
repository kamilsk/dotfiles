---
code: DOT-65
id: 66
database_id: 523843622
node_id: MDU6SXNzdWU1MjM4NDM2MjI=
status: closed
title: "wholisten <port>"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/66
created_at: 2019-11-16T13:12:18Z
updated_at: 2026-09-17T11:13:47Z
---

# wholisten <port>

Add a `wholisten` helper that answers "which process listens on this port" without remembering the `lsof` flags. The original sketch is already the definition:

```bash
$ wholisten # lsof -nP | grep LISTEN
$ wholisten port # lsof -nP -i4TCP:port | grep LISTEN
```

Without an argument it lists every listening socket (`-n`/`-P` suppress the slow name and port lookups); with a port it restricts the listing to IPv4 TCP sockets on that port. Typical use is finding what occupies a port a dev server wants, or checking that a container actually published one.
