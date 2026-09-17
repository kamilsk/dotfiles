---
code: DOT-1
id: 1
database_id: 380617341
node_id: MDU6SXNzdWUzODA2MTczNDE=
status: closed
state_reason: completed
milestone:
title: "review git_flow_jira"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/1
created_at: 2018-11-14T09:53:04Z
updated_at: 2026-09-17T10:55:57Z
---

# review git_flow_jira

Review the first Jira-oriented flow script, `git_flow_jira`, and settle what each alias in it should mean. The author's notes make three points: the entry alias `git flow` should become `git issue`; `progress`, then defined as `git commit --amend --no-edit && git push --force-with-lease mirror $branch`, mixed three concerns (amending, the `mirror` remote, pushing) and had to be split; and `ready`, then a plain `commit --amend`, is what `git progress` should mean.

The original review notes:

```
- `git flow` -> `git issue`
- `progress = !git commit --amend --no-edit && git push --force-with-lease mirror $branch`
  - mirror
  - push
  - `git progress` -> ...
- `ready = commit --amend`
  - `git ready` -> `git progress`
```

The intended result is a set of per-repository aliases with one job each: one that identifies the tracker issue behind the current branch, one that records progress on it, and separate commands for the mirror remote and for pushing.

<!-- 2018-12-06T12:44Z https://github.com/kamilsk/dotfiles/issues/1#issuecomment-444859175
add wrap option: `gitflow_jira wrapped`, unwrapped by default.

what does it mean:
- wrapped - `[ISSUE-XXX] message`
- unwrapped - `ISSUE-XXX message`
-->
