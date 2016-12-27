ssh-add >/dev/null 2>&1

alias v+="source .virtenv/bin/activate"
alias v-="deactivate"

alias g+="git fetch --all -p && git pull && git submodule update --init --recursive"
alias g-="git reset --hard && git clean -df && git submodule update --init --recursive"
alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"
function g^ {
    if [ "$1" = "" ]; then
        echo "usage: g^ <url>"
        return 1
    fi
    git remote add mirror "$1"
}
export -f g^
function g++ {
    git config alias.up '!git fetch --all -p && git pull && git submodule update --init --recursive'
    git config alias.down '!git reset --hard && git clean -df && git submodule update --init --recursive'
}
export -f g++

alias netl="netstat -an | grep LISTEN"

export GOPATH="$HOME/Development/go"
export COMPOSERPATH="$HOME/.composer"
export PATH="$PATH:/usr/local/sbin:$GOPATH/bin:$COMPOSERPATH/vendor/bin"

# refactoring

alias brewup="brew update && brew cask update && brew upgrade; \
              brew cleanup && brew cask cleanup; \
              brew doctor && brew cask doctor"
alias compup="sudo composer self-update && composer global update"
alias gemup="sudo gem update --system; gem list | cut -d ' ' -f 1 | xargs -n1 sudo gem update"
alias npmup="npm install -g npm && npm update -g"
alias pipup="sudo pip install --upgrade pip; pip list | cut -d ' ' -f 1 | xargs -n1 sudo pip install --upgrade"
alias pip3up="sudo pip3 install --upgrade pip; pip3 list | cut -d ' ' -f 1 | xargs -n1 sudo pip3 install --upgrade"
alias allup="brewup; compup; gemup; npmup"
