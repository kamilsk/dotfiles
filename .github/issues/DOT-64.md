---
code: DOT-64
id: MDU6SXNzdWU1MTgwMTY4ODk=
databaseId: 518016889
number: 65
url: https://github.com/kamilsk/dotfiles/issues/65
title: "common Brewfile"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-11-05T20:42:01Z
updatedAt: 2026-09-17T11:13:45Z
lastEditedAt: 2026-09-17T11:13:45Z
closedAt: 2019-11-17T11:03:54Z
---

# common Brewfile

Move the Homebrew package list out of the installer into a Brewfile and install from it with `brew bundle`. In 2019 the formulae were an inline list in `install.sh` ([[DOT-52]]); a Brewfile is declarative, diffable, understood by `brew bundle` for both installation and cleanup, and can be reused by `self-update`.
