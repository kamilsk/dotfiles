---
id: 334
database_id: 1287376707
node_id: I_kwDOCTsueM5Mu89D
status: closed
title: "git: config: set autocorrect"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/334
created_at: 2022-06-28T13:44:53Z
updated_at: 2022-07-29T14:43:12Z
---

# git: config: set autocorrect

**Motivation:** to improve the developer experience.

Set: `git config --global help.autoCorrect= prompt`.

Details are here https://github.blog/2021-11-15-highlights-from-git-2-34/.

> If you’ve ever accidentally typed git psuh when you meant push, you
might have seen this message:
>
> ```
> $ git push
> git: 'psuh' is not a git command. See 'git --help'.
>
> The most similar command is
>  push
> ```
>
> You have always been able to control this behavior by setting the
help.autoCorrect configuration. You can hide this advice by setting that
configuration to never, or let Git automatically rerun the most similar
command for you immediately or with a delay (by setting immediate, or a
real number of seconds to wait before rerunning your command).
>
> In Git 2.34, you can now configure Git to ask you interactively whether you
want to rerun your last operation with the suggested command by setting
help.autoCorrect to prompt.
