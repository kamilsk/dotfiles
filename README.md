> # dotfiles
>
> My dotfiles to share through environments.

[![Patreon][icon_patreon]](https://www.patreon.com/octolab)
[![License][icon_license]](LICENSE)

## Quick start

```bash
$ git clone git@github.com:kamilsk/dotfiles.git ~/.dotfiles
$ git config --global core.excludesfile ~/.dotfiles/.gitignore
# configure your Bash/Zsh
$ self-update
```

### Bash

```bash
# ~/.bash_profile

source "${HOME}"/.dotfiles/.profile
source "${HOME}"/.dotfiles/.bash_profile
```

### Zsh

```bash
# ~/.zshrc

source "${HOME}"/.dotfiles/.profile
source "${HOME}"/.dotfiles/.zshrc
```

### Installation (work in progress)

```bash
$ curl -sL https://git.io/fpN1B | bash
```

- [ ] `curl -sL https://kamil.samigullin.info/install/dotfiles | bash`

## Articles

- [Command-line completion](https://docs.docker.com/compose/completion/)
- [Flight rules for Git](https://github.com/k88hudson/git-flight-rules)
- [Most commonly used git tips and tricks](https://github.com/git-tips/tips)

## Environment

- [brew.sh](http://brew.sh/), [brew.sh at github](https://github.com/Homebrew/brew)

- [zsh](http://www.zsh.org/), [zsh at github](https://github.com/zsh-users/zsh)
  - [ohmyz.sh](http://ohmyz.sh/), [ohmyz.sh at github](https://github.com/robbyrussell/oh-my-zsh)
  - [spaceship](https://denysdovhan.com/spaceship-prompt/), [spaceship at github](https://github.com/denysdovhan/spaceship-prompt)
  - [powerline at github](https://github.com/powerline/powerline)
    - [powerline fonts at github](https://github.com/powerline/fonts)

- [vim](http://www.vim.org/), [vim at github](https://github.com/vim/vim)
  - [vim-go github](https://github.com/fatih/vim-go)
    - [vim-go tutorial at github](https://github.com/fatih/vim-go-tutorial)

## Inspiration

- [github.com/caarlos0/dotfiles](https://github.com/caarlos0/dotfiles)
- [caarlos0's dotfiles list](https://github.com/getantibody/antibody#in-the-wild)

---

[![@kamilsk][icon_tw_author]](https://twitter.com/ikamilsk)
[![@octolab][icon_tw_sponsor]](https://twitter.com/octolab_inc)

made with ❤️ by [OctoLab](https://www.octolab.org/)

[icon_license]:    https://img.shields.io/badge/license-MIT-blue.svg
[icon_patreon]:    https://img.shields.io/badge/patreon-donate-orange.svg
[icon_tw_author]:  https://img.shields.io/badge/author-%40kamilsk-blue.svg
[icon_tw_sponsor]: https://img.shields.io/badge/sponsor-%40octolab-blue.svg
[icon_twitter]:    https://img.shields.io/twitter/url/http/shields.io.svg?style=social
