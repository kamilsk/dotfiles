---
id: 151
database_id: 875581119
node_id: MDU6SXNzdWU4NzU1ODExMTk=
status: open
title: "research: composer alias support"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/151
created_at: 2021-05-04T15:29:40Z
updated_at: 2022-08-14T18:57:44Z
---

# research: composer alias support

composer uses two steps to update deps: https://stackoverflow.com/questions/16739998/how-to-update-a-single-library-with-composer

```bash
$ composer require some:version
$ composer update some
```

this chain needs investigation.

the possible solution is to add a short alias: `composer up some:version`, but the `composer` doesn't have the mechanism for that. Research:

- https://github.com/slince/composer-alias
