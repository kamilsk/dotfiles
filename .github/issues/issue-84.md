---
id: 84
database_id: 709666169
node_id: MDU6SXNzdWU3MDk2NjYxNjk=
status: closed
title: "tools problem"
labels: [help wanted, type: bug]
url: https://github.com/kamilsk/dotfiles/issues/84
created_at: 2020-09-27T04:43:22Z
updated_at: 2022-08-14T18:59:28Z
---

# tools problem

```
$ go generate tools.go
# github.com/goreleaser/nfpm/rpm
../../Development/go/pkg/mod/github.com/goreleaser/nfpm@v1.1.5/rpm/rpm.go:108:3: unknown field 'Summary' in struct literal of type rpmpack.RPMMetaData
tools.go:19: running "go": exit status 2
```
