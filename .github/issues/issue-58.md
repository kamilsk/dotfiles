---
id: 58
database_id: 496633335
node_id: MDU6SXNzdWU0OTY2MzMzMzU=
status: closed
title: "debug"
labels: [help wanted]
url: https://github.com/kamilsk/dotfiles/issues/58
created_at: 2019-09-21T08:59:46Z
updated_at: 2019-11-21T05:21:47Z
---

# debug

- `env -i bash -x -l -c 'echo 123' > login.log 2>&1`
- `strace -f env -i bash -x -l -c 'echo 123' > login.log 2>&1`
- `grep -Fz SUDO_USER /proc/10684/environ`

inspiration https://habr.com/ru/company/badoo/blog/465021/
