---
id: 204
database_id: 1061659917
node_id: I_kwDOCTsueM4_R6UN
status: closed
title: "duplication after multiple installations"
labels: [type: bug]
url: https://github.com/kamilsk/dotfiles/issues/204
created_at: 2021-11-23T20:00:31Z
updated_at: 2022-08-14T18:59:32Z
---

# duplication after multiple installations

```
$ cat ~/.bash_profile 
source '/Users/.../.dotfiles'/.profile
source '/Users/.../.dotfiles'/.bash_profile
...
source '/Users/.../.dotfiles'/.profile
source '/Users/.../.dotfiles'/.bash_profile
```
