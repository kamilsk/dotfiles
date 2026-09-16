---
code: DOT-32
id: 32
database_id: 450192739
node_id: MDU6SXNzdWU0NTAxOTI3Mzk=
status: closed
title: "volumes not work properly"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/32
created_at: 2019-05-30T08:33:09Z
updated_at: 2026-09-17T11:05:54Z
---

# volumes not work properly

Make the `volumes` helper work in an interactive bash on Ubuntu, where it produced:

```
# volumes
No command '-bash' found, did you mean:
 Command 'bash' from package 'bash' (main)
 Command 'rbash' from package 'bash' (main)
-bash: command not found
```

The helper re-invoked itself through `$0` to reuse its own `all` branch. Inside a function sourced into a login shell, `$0` is the shell's name — `-bash` — not a script path, so the recursion tried to execute a program called `-bash`. The idiom works only in a standalone script.
