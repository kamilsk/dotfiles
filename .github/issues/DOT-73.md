---
code: DOT-73
id: 74
database_id: 594833886
node_id: MDU6SXNzdWU1OTQ4MzM4ODY=
status: closed
title: "new aliases as touch alternatives"
labels: ["help wanted"]
url: https://github.com/kamilsk/dotfiles/issues/74
created_at: 2020-04-06T06:18:13Z
updated_at: 2026-09-17T11:14:29Z
---

# new aliases as touch alternatives

Add `edit` and `append` as alternatives to `touch`: create or extend a small file by typing its content into a heredoc at the prompt, instead of `touch` plus an editor. The original sketch:

```bash
$ edit some.txt
# cat <<EOF > some.txt

$ append some.txt
# cat <<EOF >> some.txt
```

After the command the shell keeps reading lines until a line with `EOF`, then writes them to the file — `edit` overwrites, `append` adds to the end. The point is speed for the one-paragraph notes, `.gitignore` entries and config stubs that do not deserve opening an editor; the "help wanted" label presumably asked for ideas on the naming or the mechanism.
