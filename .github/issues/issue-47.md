---
id: 47
database_id: 469198653
node_id: MDU6SXNzdWU0NjkxOTg2NTM=
status: closed
title: "extend coverall"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/47
created_at: 2019-07-17T13:37:21Z
updated_at: 2019-07-21T06:45:01Z
---

# extend coverall

```
cover () {
    local t=$(mktemp -t cover)
    go test $COVERFLAGS -coverprofile=$t $@ \
        && go tool cover -func=$t \
        && unlink $t
}
```
