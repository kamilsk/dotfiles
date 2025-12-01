---
id: 108
database_id: 790772234
node_id: MDU6SXNzdWU3OTA3NzIyMzQ=
status: closed
title: "git undo has buggy behavior"
labels: [help wanted, type: bug]
url: https://github.com/kamilsk/dotfiles/issues/108
created_at: 2021-01-21T07:22:05Z
updated_at: 2022-08-14T18:59:29Z
---

# git undo has buggy behavior

```sh
$ git undo 2
fatal: неоднозначный аргумент «HEAD^2»: неизвестная редакция или не путь в рабочем каталоге.
Используйте «--» для отделения путей от редакций, вот так:
«git <команда> [<редакция>…] -- [<файл>…]»
```
