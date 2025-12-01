---
id: 648
database_id: 2010973265
node_id: I_kwDOCTsueM533QRR
status: closed
title: "git: alias: please doesn't respect tracking state"
labels: [type: bug, severity: critical, scope: code, impact: high, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/648
created_at: 2023-11-26T09:46:35Z
updated_at: 2023-11-26T09:55:15Z
---

# git: alias: please doesn't respect tracking state

**Details**

```
  for remote in $(git remote | grep -Ev '^(upstream|fork-.*)$'); do
    git push --force-with-lease --tags "${remote}" "$(git current)"
  done
```
https://github.com/kamilsk/dotfiles/blob/dce0b935e6cb99473ae499e69394b99b45b837f1/bin/git_please#L12-L14

I use forks for https://github.com/octolab/.github and configure their branches to appropriate remotes, e.g., 
- branch lifeos -> upstream fork-lifeos

When I use `git please` it pushes to the origin upstream, not fork! It replaces history.
