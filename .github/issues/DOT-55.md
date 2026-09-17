---
code: DOT-55
id: 56
database_id: 487790988
node_id: MDU6SXNzdWU0ODc3OTA5ODg=
status: closed
state_reason: completed
milestone:
title: "git open"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/56
created_at: 2019-08-31T17:10:24Z
updated_at: 2026-09-17T11:12:33Z
---

# git open

Add `git open`: detect the web URL of the repository from its remote and open it in the browser. The whole note is "autodetect url and open it". The remotes are SSH URLs (`git@github.com:owner/repo.git`, `git@bitbucket.org:…`), so the command has to translate one into `https://github.com/owner/repo` before calling `open`.

Expected: with no arguments the remote tracked by the current branch is used; GitHub and Bitbucket URLs in SSH and HTTPS form are recognised; a remote whose URL cannot be translated yields an error, not a broken browser tab; another remote (for example the mirror, [[DOT-56]]) can be chosen.
