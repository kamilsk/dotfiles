---
id: 457
database_id: 1420768843
node_id: I_kwDOCTsueM5UrzZL
status: open
title: "git: alias: add meta command"
labels: [type: feature, scope: code, impact: low, effort: easy]
url: https://github.com/kamilsk/dotfiles/issues/457
created_at: 2022-10-24T12:41:31Z
updated_at: 2022-10-24T12:41:31Z
---

# git: alias: add meta command

**Motivation:** show metadata of commits to overview its consistency.

**Interface**

```bash
$ git meta [HEAD~5]
# git log --quiet --pretty=fuller ? # here is a problem with HEAD~5 logic
```
