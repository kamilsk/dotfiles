> # shared:dotfiles/research
> [![Analytics][analytics_pixel]](https://github.com/kamilsk/shared/tree/dotfiles)
> Researches.

[![Patreon][icon_patreon]](https://www.patreon.com/octolab)
[![License][icon_license]](LICENSE)

## Articles

- https://habr.com/company/mailru/blog/318508/
- https://csswizardry.com/2017/03/configuring-git-and-vim/
- https://blog.scottnonnenberg.com/better-git-configuration/
- https://csswizardry.com/2017/05/little-things-i-like-to-do-with-git/
- https://laravel-news.com/bash-aliases
- https://laravel-news.com/laravel-homestead-aliases

## Draft

```
# TODO review https://csswizardry.com/2017/05/little-things-i-like-to-do-with-git/
function git_review_203 {
    git config alias.stats     'shortlog -sn --all --no-merges'
    git config alias.recent    'for-each-ref --count=10 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
    git config alias.overview  '!git log --oneline --no-merges --all --since="1 week"'
    git config alias.recap     "!git log --oneline --no-merges --all --author=\$(git user) --since='1 week'"
    git config alias.today     "!git log --oneline --no-merges --all --author=\$(git user) --since='00:00:00'"
    git config alias.yesterday "!git log --oneline --no-merges --all --author=\$(git user) --since='1 day' --until='00:00:00'"
    git config alias.changelog "!git log --oneline --no-merges \$(git release).."
    git config alias.ahead     "!git log --oneline --no-merges origin/\$(git current).."
    git config alias.behind    "!git log --oneline --no-merges ..origin/\$(git current)"
}
```

```
# TODO review https://blog.scottnonnenberg.com/better-git-configuration/
# read
# - https://github.com/pstadler/keybase-gpg-github
# - https://help.github.com/articles/telling-git-about-your-gpg-key/
function git_review_173 {
    git config alias.overview  'log --oneline --no-merges @{1.week.ago}..'
    git config alias.recap     "!git log --oneline --no-merges --author=\$(git user) @{1.week.ago}.."
    git config alias.today     "!git log --oneline --no-merges --author=\$(git user) @{00:00:00}.."
    git config alias.yesterday "!git log --oneline --no-merges --author=\$(git user) @{yesterday}..@{00:00:00}"

    git config alias.undo      'reset --soft HEAD^'

    # gpg --list-secret-keys --keyid-format LONG
    # git config user.signingkey ...
    git config commit.gpgSign  'true'
    git config alias.cmm       'commit -S -m'
    export GPG_TTY=$(tty)

    git config merge.ff                  'only'
    git config merge.conflictstyle       'diff3'
    git config push.default              'simple'
    git config push.followTags           'true'
    git config status.showUntrackedFiles 'all'
    git config transfer.fsckobjects      'true'
}
```

---

[![@kamilsk][icon_tw_author]](https://twitter.com/ikamilsk)
[![@octolab][icon_tw_sponsor]](https://twitter.com/octolab_inc)

made with ❤️ by [OctoLab](https://www.octolab.org/)

[analytics_pixel]: https://ga-beacon.appspot.com/UA-109817251-4/shared/dotfiles:research?pixel

[icon_license]:    https://img.shields.io/badge/license-MIT-blue.svg
[icon_patreon]:    https://img.shields.io/badge/patreon-donate-orange.svg
[icon_tw_author]:  https://img.shields.io/badge/author-%40kamilsk-blue.svg
[icon_tw_sponsor]: https://img.shields.io/badge/sponsor-%40octolab-blue.svg
[icon_twitter]:    https://img.shields.io/twitter/url/http/shields.io.svg?style=social
