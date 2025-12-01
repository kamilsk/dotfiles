---
id: 359
database_id: 1322579243
node_id: I_kwDOCTsueM5O1PUr
status: open
title: "git: alias: refactor alias.refresh, alias.shake, and alias.untag"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/359
created_at: 2022-07-29T18:52:30Z
updated_at: 2025-08-10T06:51:55Z
---

# git: alias: refactor alias.refresh, alias.shake, and alias.untag

**Motivation:** improve code quality and remove `git_*` scripts, see #355.

**To do**

- move them into `git/sync.bash`
- replace by `!@ git-refresh`, `!@ git-shake`, and `!@ git-please`

**Action items**

- [ ] plan #146
- [ ] plan #239
- [ ] plan #123
- [ ] plan #160
