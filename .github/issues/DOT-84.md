---
code: DOT-84
id: 85
database_id: 733729090
node_id: MDU6SXNzdWU3MzM3MjkwOTA=
status: closed
state_reason: completed
milestone:
title: "brew cask upgrade is deprecated"
labels: ["help wanted"]
url: https://github.com/kamilsk/dotfiles/issues/85
created_at: 2020-10-31T14:10:53Z
updated_at: 2026-09-17T11:15:15Z
---

# brew cask upgrade is deprecated

Replace `brew cask upgrade` in `self-update` with `brew upgrade --cask`. Homebrew folded the `brew cask` subcommand into the main CLI in 2.5–2.6 (autumn 2020) and printed a deprecation warning on every run of the old form, which the update script hit on each `self-update brew`.
