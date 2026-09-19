---
code: DOT-8
id: MDU6SXNzdWUzOTYyNTk3OTQ=
databaseId: 396259794
number: 8
url: https://github.com/kamilsk/dotfiles/issues/8
title: "add explainshell.com"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-01-06T13:48:46Z
updatedAt: 2026-09-17T11:14:48Z
lastEditedAt: 2026-09-17T11:14:48Z
closedAt: 2019-01-06T19:14:21Z
---

# add explainshell.com

Add a helper that hands a command line to [explainshell.com](https://www.explainshell.com), the site that splits a shell command into its parts and annotates every flag from the man pages. The author's own aliases and scripts are full of dense one-liners, and a one-word way to get them explained in the browser was wanted instead of pasting them by hand. The original note is just the link to the site.

The expected interface is a shell function that takes the command words as arguments and opens the corresponding `explain?cmd=…` page; nothing is printed or executed locally.
