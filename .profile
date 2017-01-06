ssh-add >/dev/null 2>&1

alias g+="git fetch --all -p && git pull && git submodule update --init --recursive"
alias g-="git reset --hard && git clean -df && git submodule update --init --recursive"
alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"
alias g^="branch=\$(git branch | cut -f2 -d' '); git push origin \$branch --tags && git push mirror \$branch --tags"
function g++ {
    git remote -v | grep mirror > /dev/null
    exists=$?
    if [ ${exists} != 0 ]; then
        if [ "$1" = "" ]; then
            echo "usage: g++ <url>"
            return 1
        else
            git remote add mirror "$1"
        fi
    elif [ "$1" != "" ]; then
        git remote set-url mirror "$1"
    fi

    git config alias.up '!git fetch --all -p && git pull && git submodule update --init --recursive'
    git config alias.down '!git reset --hard && git clean -df && git submodule update --init --recursive'
    git config alias.pub "!branch=\$(git branch | cut -f2 -d' '); git push origin \$branch --tags && git push mirror \$branch --tags"
}

alias v+="source .virtenv/bin/activate"
alias v-="deactivate"

alias brew+="brew update && brew upgrade && \
             brew cleanup && brew cask cleanup && \
             brew doctor && brew cask doctor"
alias composer+="sudo composer self-update && composer global update"
alias gem+="sudo gem update --system; gem list | cut -f1 -d' ' | xargs -n1 sudo gem update"
alias npm+="npm install -g npm && npm update -g"
alias pip+="sudo pip install --upgrade pip; pip list | cut -f1 -d' ' | xargs -n1 sudo pip install --upgrade"

alias netl="netstat -an | grep LISTEN"

export GOPATH="$HOME/Development/go"
export COMPOSERPATH="$HOME/.composer"
export PATH="$PATH:/usr/local/sbin:$GOPATH/bin:$COMPOSERPATH/vendor/bin"
