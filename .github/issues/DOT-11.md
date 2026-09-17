---
code: DOT-11
id: 11
database_id: 408665463
node_id: MDU6SXNzdWU0MDg2NjU0NjM=
status: closed
state_reason: completed
milestone:
title: "mac configuration to use touchid"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/11
created_at: 2019-02-11T07:46:19Z
updated_at: 2026-09-17T10:56:43Z
---

# mac configuration to use touchid

Let `sudo` authenticate with Touch ID on the Mac, so that the frequent `sudo` calls of the installation and update scripts (Homebrew, `gem`/`pip` upgrades, `flushdns`) do not require typing the password. The recipe the author linked is the [osxdaily article](http://osxdaily.com/2017/11/22/use-touch-id-sudo-mac/): add `auth sufficient pam_tid.so` as the first line of `/etc/pam.d/sudo`.

Expected behaviour: a one-shot command in the dotfiles applies the PAM change idempotently (it must not add the line twice), shows the resulting file, and needs `sudo` itself only for the final write. Reverting the change or handling other PAM services is out of scope.
