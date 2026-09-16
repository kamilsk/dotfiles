---
code: DOT-64
id: 65
database_id: 518016889
node_id: MDU6SXNzdWU1MTgwMTY4ODk=
status: closed
title: "common Brewfile"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/65
created_at: 2019-11-05T20:42:01Z
updated_at: 2026-09-17T11:13:45Z
---

# common Brewfile

Move the Homebrew package list out of the installer into a Brewfile and install from it with `brew bundle`. In 2019 the formulae were an inline list in `install.sh` ([#53](DOT-52.md)); a Brewfile is declarative, diffable, understood by `brew bundle` for both installation and cleanup, and can be reused by `self-update`.
