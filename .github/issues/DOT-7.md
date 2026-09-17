---
code: DOT-7
id: 7
database_id: 394978629
node_id: MDU6SXNzdWUzOTQ5Nzg2Mjk=
status: closed
state_reason: completed
milestone:
title: "new alias git issue"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/7
created_at: 2018-12-31T13:12:00Z
updated_at: 2026-09-17T11:14:04Z
---

# new alias git issue

Add a `git issue` alias that opens the tracker page of the issue the current branch belongs to. With the branch naming used by the flow (`issue-<id>-…` for GitHub, `<KEY>-<n>-…` for Jira) the issue is known from the branch name, so one command can build the URL and hand it to the browser. Original wording: "`git issue` must opens browser with page with related issue".

Expected: on a branch created by `git start`, `git issue` opens `https://github.com/<owner>/<repo>/issues/<id>` (or `<jira>/browse/<KEY>-<n>`) in the default browser; on a branch that does not follow the convention it fails with a clear message rather than opening a broken URL.
