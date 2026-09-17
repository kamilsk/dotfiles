---
code: DOT-49
id: 50
database_id: 477224982
node_id: MDU6SXNzdWU0NzcyMjQ5ODI=
status: closed
state_reason: completed
milestone:
title: "improve git issue alias"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/50
created_at: 2019-08-06T07:52:50Z
updated_at: 2026-09-17T11:11:34Z
---

# improve git issue alias

Turn `git issue` into `git issue [action]`, with `echo` as the default action and `open` as the first alternative, so that the tracker page opens without piping to `xargs`. The original before/after:

```bash
# how to open the issue now
$ git issue | xargs open

# how it should be
$ git issue open
```

"So, the rule is `git issue [action]`, where the action is `echo` by default." This restates [[DOT-22]] (print / open / copy) as a general rule instead of a fixed list: the action is a command that receives the URL, which makes `git issue pbcopy` work for free.

Expected: `git issue` prints the URL; `git issue <cmd>` runs `<cmd> <url>`; the URL is derived from the branch name exactly as before, for both the GitHub and the Jira flavour.

<!-- 2019-08-13T07:55Z https://github.com/kamilsk/dotfiles/issues/50#issuecomment-520730149
difficult to implement
-->
