---
id: 227
database_id: 1080624324
node_id: I_kwDOCTsueM5AaQTE
status: closed
title: "git nah works incorrectly with git submodules"
labels: [type: bug]
url: https://github.com/kamilsk/dotfiles/issues/227
created_at: 2021-12-15T06:27:54Z
updated_at: 2022-08-14T18:59:33Z
---

# git nah works incorrectly with git submodules

```
git nah
HEAD is now at 8f68377d9 ...
error: the following file has local modifications:
    resources/public_api/specs
(use --cached to keep the file, or -f to force removal)
fatal: Submodule work tree 'resources/public_api/specs' contains local modifications; use '-f' to discard them

-> git submodule deinit --all --force

-? git submodule foreach --recursive git reset --hard
-? git submodule update -f --recursive
-? git restore . --recurse-submodules
-? git reset --hard --recurse-submodule
```
