---
id: 25
database_id: 443775161
node_id: MDU6SXNzdWU0NDM3NzUxNjE=
status: closed
title: "invalid behavior of git start and git refresh"
labels: [type: bug]
url: https://github.com/kamilsk/dotfiles/issues/25
created_at: 2019-05-14T08:22:25Z
updated_at: 2022-08-14T18:59:51Z
---

# invalid behavior of git start and git refresh

```bash
$ git start 34
fatal: empty string is not a valid pathspec. please use . instead if you meant to match all paths
done

$ git start 34 port types
...
Current branch master is up to date.
Switch to the new branch «issue-34-port-types»
done

$ git refresh upstream
...
Current branch master is up to date.
# but git log shows that it is not true
```
