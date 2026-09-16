---
code: DOT-24
id: 24
database_id: 442975113
node_id: MDU6SXNzdWU0NDI5NzUxMTM=
status: closed
title: "explain shell script"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/24
created_at: 2019-05-11T09:45:23Z
updated_at: 2019-06-21T05:32:40Z
---

# explain shell script

Make the explainshell integration reach the author's own aliases and scripts, not only commands typed by hand: `git aliases` should print each alias together with an explainshell link for its body, and `explain` should accept an arbitrary command line, including a `git` alias invocation.

The original sketch:

```bash
$ git aliases
...
cmm ... https://www.explainshell.com/explain?cmd=commit%28%29+%7B+git+commit+-m+%22%24*%22%3B+%7D%3B+commit

$ explain git aliases
$ explain some command
```

The first line illustrates the format: the alias name, its definition (here the `cmm` alias of that time, a `commit()` function committing with the arguments as the message) and a URL-encoded explainshell link for it. The listing needs the alias body encoded so that spaces, braces and `$*` survive in the query; plain `explain` only needs to forward the words.
