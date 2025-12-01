---
id: 285
database_id: 1206151910
node_id: I_kwDOCTsueM5H5Grm
status: closed
title: "self-update: pull docker images"
labels: [type: bug]
url: https://github.com/kamilsk/dotfiles/issues/285
created_at: 2022-04-16T16:06:22Z
updated_at: 2022-08-14T18:59:35Z
---

# self-update: pull docker images

```
$ self-update docker
...
invalid reference format
invalid reference format
invalid reference format
invalid reference format
...
# exit code 1
```

because

```
$ images all
redis                                <none>                              40acfa265b76   3 weeks ago    32.4MB
nginx                                <none>                              3dc166bc6b35   3 weeks ago    22MB
golang                               <none>                              a6562e325080   4 weeks ago    805MB
minio/mc                             <none>                              35295c93c07e   4 weeks ago    158MB
```
