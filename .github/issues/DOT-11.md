---
code: DOT-11
id: MDU6SXNzdWU0MDg2NjU0NjM=
databaseId: 408665463
number: 11
url: https://github.com/kamilsk/dotfiles/issues/11
title: "mac configuration to use touchid"
labels: []
milestone:
state: CLOSED
stateReason: COMPLETED
createdAt: 2019-02-11T07:46:19Z
updatedAt: 2026-09-17T10:56:43Z
lastEditedAt: 2026-09-17T10:56:43Z
closedAt: 2019-03-03T06:26:34Z
---

# mac configuration to use touchid

Let `sudo` authenticate with Touch ID on the Mac, so that the frequent `sudo` calls of the installation and update scripts (Homebrew, `gem`/`pip` upgrades, `flushdns`) do not require typing the password. The recipe the author linked is the [osxdaily article](http://osxdaily.com/2017/11/22/use-touch-id-sudo-mac/): add `auth sufficient pam_tid.so` as the first line of `/etc/pam.d/sudo`.

Expected behaviour: a one-shot command in the dotfiles applies the PAM change idempotently (it must not add the line twice), shows the resulting file, and needs `sudo` itself only for the final write. Reverting the change or handling other PAM services is out of scope.
