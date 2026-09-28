# Zsh

## Reload the current session

`install` adds a source line to `~/.zshrc`, which loads
[`config/zsh/.zshrc`](.zshrc), Oh My Zsh, and then `bin/lib/*.bash`.
`reload` in [`bin/lib/aliases.bash`](../../bin/lib/aliases.bash)
re-reads the user `.zprofile` when present, then `.zshrc`, and runs `rehash`.
It respects `${ZDOTDIR:-$HOME}`; `.zprofile` reapplies the machine's PATH setup.
To load the new alias in an existing session:

```sh
source "${ZDOTDIR:-$HOME}/.zshrc"
reload
```

Sourcing runs at the caller's scope so `typeset -U path` stays in effect.
If sourcing fails, later steps are skipped. Plugins and hooks run again.

## Config file

Template of `.zshrc` is located [here](https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template).

## Useful resources

- [Zsh](https://www.zsh.org), [Zsh at GitHub](https://github.com/zsh-users/zsh)
- [Oh My Zsh](https://ohmyz.sh), [Oh My Zsh at GitHub](https://github.com/ohmyzsh/ohmyzsh)

- [Additional completion definitions for Zsh](https://github.com/zsh-users/zsh-completions).
- [Powerline](https://github.com/powerline/powerline).
