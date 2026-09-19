---
code: DOT-65
id: MDU6SXNzdWU1MjM4NDM2MjI=
databaseId: 523843622
number: 66
url: https://github.com/kamilsk/dotfiles/issues/66
title: "wholisten <port>"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-11-16T13:12:18Z
updatedAt: 2026-09-17T11:13:47Z
lastEditedAt: 2026-09-17T11:13:47Z
closedAt: 2019-11-17T11:28:42Z
---

# wholisten <port>

Add a `wholisten` helper that answers "which process listens on this port" without remembering the `lsof` flags. The original sketch is already the definition:

```bash
$ wholisten # lsof -nP | grep LISTEN
$ wholisten port # lsof -nP -i4TCP:port | grep LISTEN
```

Without an argument it lists every listening socket (`-n`/`-P` suppress the slow name and port lookups); with a port it restricts the listing to IPv4 TCP sockets on that port. Typical use is finding what occupies a port a dev server wants, or checking that a container actually published one.
