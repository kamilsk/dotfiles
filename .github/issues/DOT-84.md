---
code: DOT-84
id: MDU6SXNzdWU3MzM3MjkwOTA=
databaseId: 733729090
number: 85
url: https://github.com/kamilsk/dotfiles/issues/85
title: "brew cask upgrade is deprecated"
issueType: null
labels:
  - "help wanted"
assignees:
  - kamilsk
milestone: null
parent: null
issueFields: {}
state: CLOSED
stateReason: COMPLETED
duplicateOf: null
createdAt: 2020-10-31T14:10:53Z
updatedAt: 2026-09-17T11:15:15Z
lastEditedAt: 2026-09-17T11:15:15Z
closedAt: 2020-10-31T14:44:06Z
---

# brew cask upgrade is deprecated

Replace `brew cask upgrade` in `self-update` with `brew upgrade --cask`. Homebrew folded the `brew cask` subcommand into the main CLI in 2.5–2.6 (autumn 2020) and printed a deprecation warning on every run of the old form, which the update script hit on each `self-update brew`.
