---
code: DOT-8
id: 8
database_id: 396259794
node_id: MDU6SXNzdWUzOTYyNTk3OTQ=
status: closed
state_reason: completed
milestone:
title: "add explainshell.com"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/8
created_at: 2019-01-06T13:48:46Z
updated_at: 2026-09-17T11:14:48Z
---

# add explainshell.com

Add a helper that hands a command line to [explainshell.com](https://www.explainshell.com), the site that splits a shell command into its parts and annotates every flag from the man pages. The author's own aliases and scripts are full of dense one-liners, and a one-word way to get them explained in the browser was wanted instead of pasting them by hand. The original note is just the link to the site.

The expected interface is a shell function that takes the command words as arguments and opens the corresponding `explain?cmd=…` page; nothing is printed or executed locally.
