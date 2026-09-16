---
code: DOT-43
id: 44
database_id: 462424647
node_id: MDU6SXNzdWU0NjI0MjQ2NDc=
status: closed
title: "self-update and unbound variable"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/44
created_at: 2019-06-30T16:51:43Z
updated_at: 2026-09-17T11:10:30Z
---

# self-update and unbound variable

Make an unknown target a graceful error instead of a crash. With a typo in the target name the script reported it and then died on the next line:

```
$ self-update sll
unknown type sll
/Users/.../.dotfiles/bin/self-update: line 65: UPDATE[@]: unbound variable
```

The script runs with `set -u`, collects the requested `update_*` functions in the `UPDATE` array and iterates over `"${UPDATE[@]}"`. When every argument is unknown the array stays empty, and in bash before 4.4 (macOS ships 3.2) expanding an empty array under `nounset` is an error. The same class of failure as [#9](DOT-9.md).

Expected: `self-update <typo>` prints the unknown type and exits without a shell error; a mix of valid and invalid types runs the valid ones.

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/44#issuecomment-5711705531
Code vs intent: the "fix" appends `echo unknown type: ${type}` to the `UPDATE` array and later `eval`s each element. The user-supplied type name therefore reaches `eval` unquoted (a type name carrying shell metacharacters is executed as written). `.github/reviews/20260709T130934Z.md` finding 8. A `case` that prints and `exit 1` would be both safer and what the ticket asked for.
-->
