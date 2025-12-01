---
id: 240
database_id: 1099579582
node_id: I_kwDOCTsueM5BikC-
status: open
title: "script to calculate date between to git commits"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/240
created_at: 2022-01-11T20:16:39Z
updated_at: 2022-08-14T18:54:12Z
---

# script to calculate date between to git commits

- `git rev-list -n 1 release-202201111351`
- `git show --no-patch --no-notes --pretty='%cI' 24214c334e9416b52d0dc67c3140c25f10893a56 | cat`
- `date +"%Y-%m-%dT%H:%M:%S%z"`
- https://stackoverflow.com/questions/4946785/how-to-find-the-difference-in-days-between-two-dates/6948865
