---
id: 353
database_id: 1319313712
node_id: I_kwDOCTsueM5OoyEw
status: closed
title: "git: alias: improve amend with GIT_COMMITTER_DATE"
labels: [type: bug]
url: https://github.com/kamilsk/dotfiles/issues/353
created_at: 2022-07-27T09:57:25Z
updated_at: 2022-08-14T18:59:36Z
---

# git: alias: improve amend with GIT_COMMITTER_DATE

**Motivation:** this parameter was ignored and it worsens experience with GitHub.

**Algorithm**

```
$ ts=git --no-pager log -1 --format="%as"
$ GIT_COMMITTER_DATE=$ts git commit --amend --no-edit
```
