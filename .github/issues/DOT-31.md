---
code: DOT-31
id: 31
database_id: 450192010
node_id: MDU6SXNzdWU0NTAxOTIwMTA=
status: closed
state_reason: completed
milestone:
title: "images not work properly"
labels: ["type: bug"]
url: https://github.com/kamilsk/dotfiles/issues/31
created_at: 2019-05-30T08:31:04Z
updated_at: 2026-09-17T11:05:28Z
---

# images not work properly

Make the `images` helper work on Linux. On Ubuntu it failed at once:

```
# images all
tail: cannot open '+2' for reading: No such file or directory
```

The helper stripped the header line of `docker images` with `tail +2`. BSD `tail` on macOS accepts that legacy spelling; GNU `tail` treats `+2` as a file name. The portable form is `tail -n +2`.
