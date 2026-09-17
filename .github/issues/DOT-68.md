---
code: DOT-68
id: 69
database_id: 535538364
node_id: MDU6SXNzdWU1MzU1MzgzNjQ=
status: closed
state_reason: completed
milestone:
title: "change git release"
labels: ["severity: critical"]
url: https://github.com/kamilsk/dotfiles/issues/69
created_at: 2019-12-10T07:07:36Z
updated_at: 2026-09-17T11:14:02Z
---

# change git release

Make the "ahead of the last tag" part of `git release` readable:

```bash
$ git release
1.11.0 [1-ga4bc8a5] -> 1.11.0 (1 ahead ga4bc8a5)
```

`git describe --tags` yields `1.11.0-1-ga4bc8a5` when `HEAD` is one commit past the tag; the command showed the raw `-1-ga4bc8a5` suffix in brackets, which reads as part of the version. The ask is to spell out what the numbers mean. Marked `severity: critical` at the time, presumably because the output fed other scripts or the shell prompt.

<!-- 2019-12-21T18:27Z https://github.com/kamilsk/dotfiles/issues/69#issuecomment-568201676
```
$ git describe --tags
0.5.5-4-gcaf34db
$ git release
0.5.5
```
-->

<!-- 2019-12-25T09:16Z https://github.com/kamilsk/dotfiles/issues/69#issuecomment-568871907
```
$ git describe --tags
0.5.0-8-gcfce164
$ git release
0.5.0
```
-->
