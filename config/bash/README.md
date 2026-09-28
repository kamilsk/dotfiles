# Bash

## Reload the current session

`install` adds a source line to `~/.bash_profile`, which loads
[`config/bash/.bash_profile`](.bash_profile) and then `bin/lib/*.bash`.
`reload` in [`bin/lib/aliases.bash`](../../bin/lib/aliases.bash)
re-reads that user profile in the current shell, then clears command paths with
`hash -r`. To load the new alias in an existing session:

```sh
source ~/.bash_profile
reload
```

If sourcing fails, the error is returned and the cache reset is skipped.
