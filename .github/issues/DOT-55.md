---
code: DOT-55
id: MDU6SXNzdWU0ODc3OTA5ODg=
databaseId: 487790988
number: 56
url: https://github.com/kamilsk/dotfiles/issues/56
title: "git open"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-08-31T17:10:24Z
updatedAt: 2026-09-17T11:12:33Z
lastEditedAt: 2026-09-17T11:12:33Z
closedAt: 2019-09-02T14:56:44Z
---

# git open

Add `git open`: detect the web URL of the repository from its remote and open it in the browser. The whole note is "autodetect url and open it". The remotes are SSH URLs (`git@github.com:owner/repo.git`, `git@bitbucket.org:…`), so the command has to translate one into `https://github.com/owner/repo` before calling `open`.

Expected: with no arguments the remote tracked by the current branch is used; GitHub and Bitbucket URLs in SSH and HTTPS form are recognised; a remote whose URL cannot be translated yields an error, not a broken browser tab; another remote (for example the mirror, [[DOT-56]]) can be chosen.
