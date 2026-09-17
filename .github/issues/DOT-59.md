---
code: DOT-59
id: 60
database_id: 512473444
node_id: MDU6SXNzdWU1MTI0NzM0NDQ=
status: closed
state_reason: completed
milestone:
title: "git release didn't show postfix (rc/alpha)"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/60
created_at: 2019-10-25T11:53:09Z
updated_at: 2026-09-17T11:12:52Z
---

# git release didn't show postfix (rc/alpha)

Keep the pre-release suffix when `git release` prints the current tag:

```
$ git log
commit 234ae18a01f91e2e12dba56cc0a4956a5178729f (HEAD -> master, tag: 1.0.0-rc1, origin/master, origin/HEAD)

$ git release
1.0.0
# 1.0.0-rc1 expected
```

`git release` is the `release` branch of [git_current](../../bin/git_current); it prettifies `git describe --tags`. The prettifier split on `-` to detect the `<tag>-<n>-g<hash>` "ahead" form and discarded everything after the first dash, so a release candidate lost its `-rc1`.

Expected: a tag such as `1.0.0-rc1` is shown in full; the ahead suffix is still recognised and shown separately.

<!-- 2019-11-19T19:51Z https://github.com/kamilsk/dotfiles/issues/60#issuecomment-555681078
expected behavior

```
1.0.0-3-gc05ab1c -> 1.0.0
1.0.0-rc1        -> 1.0.0 rc1
```
-->

<!-- 2026-09-16T05:49Z https://github.com/kamilsk/dotfiles/issues/60#issuecomment-5711714552
Code vs intent: `git_current` line ~34 uses `grep -v '[:alpha:]'` outside a bracket-in-bracket, i.e. it matches the literal characters `:` `a` `l` `p` `h`, not "letters". It filters `alpha`, `beta`, `latest`, `goimports` by accident and keeps tags such as `next` or `v1.2.3-rc1`. `.github/reviews/20260709T130934Z.md` finding 11. Same issue affects #169.
-->
