---
id: 55
database_id: 487790629
node_id: MDU6SXNzdWU0ODc3OTA2Mjk=
status: closed
title: "git refresh works not well"
labels: [type: bug]
url: https://github.com/kamilsk/dotfiles/issues/55
created_at: 2019-08-31T17:06:44Z
updated_at: 2022-08-14T18:59:55Z
---

# git refresh works not well

```bash
for fork in $(ls | grep fork-); do (cd $fork; git refresh upstream master; g^); done
Извлечение из origin
Извлечение из upstream
fatal: invalid upstream 'upstream/research'
done
Everything up-to-date
Извлечение из origin
Извлечение из upstream
fatal: invalid upstream 'upstream/research'
done
Everything up-to-date
Извлечение из origin
Извлечение из upstream
fatal: invalid upstream 'upstream/research'
done
Everything up-to-date
```
