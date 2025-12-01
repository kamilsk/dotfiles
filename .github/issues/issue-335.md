---
id: 335
database_id: 1287409429
node_id: I_kwDOCTsueM5MvE8V
status: closed
title: "git: config: define merge.conflictStyle"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/335
created_at: 2022-06-28T14:08:29Z
updated_at: 2022-07-29T14:39:51Z
---

# git: config: define merge.conflictStyle

**Motivation:** to reduce noise and improve readability.

Set: `git config --global merge.conflictStyle=zdiff3`.

Details are here https://github.blog/2022-01-24-highlights-from-git-2-35/.

> If you’ve ever dealt with a merge conflict, you know that accurately resolving conflicts takes some careful thinking. You may not have heard of Git’s [merge.conflictStyle setting](https://git-scm.com/docs/git-config#Documentation/git-config.txt-mergeconflictStyle), which makes resolving conflicts just a little bit easier.
>
> The default value for this configuration is “merge”, which produces the merge conflict markers that you are likely familiar with. But there is a different mode, “diff3”, which shows the merge base in addition to the changes on either side.
>
> Git 2.35 introduces a new mode, “zdiff3”, which zealously moves any lines in common at the beginning or end of a conflict outside of the conflicted area, which makes the conflict you have to resolve a little bit smaller.
