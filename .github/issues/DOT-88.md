---
code: DOT-88
id: 89
database_id: 774776710
node_id: MDU6SXNzdWU3NzQ3NzY3MTA=
status: closed
title: "extend lookup command"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/89
created_at: 2020-12-25T19:35:33Z
updated_at: 2020-12-27T15:37:41Z
---

# extend lookup command

Let `lookup git <alias>` follow a git alias down to the code that implements it. Many aliases of that time were `!git_commit at`-style shell-outs to scripts in `bin/`, so seeing only the alias body answered half of the question. The original sketch:

```bash
$ lookup git at
# git config alias.at
# !git_commit at
# lookup git_commit
```

That is: print the alias as `git config` returns it, and when the body starts with `!git_…` recurse into `lookup` for that script, which prints its source ([#40](DOT-39.md)). Aliases whose body is plain git (`stash --keep-index`) or an inline shell snippet are shown as they are.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/89#issuecomment-5711716025
Code vs intent: `lookup git <alias>` recursion is keyed on `!git_` and therefore stops at `!@ git-at` for every alias defined since 2021 (`at`, `cmm`, `amend`, `it`, `undo`, `contrib`, `rewrite`, stash family). Extending the match to `!@ ` and resolving the function in the sourced libraries would restore the feature.
-->
