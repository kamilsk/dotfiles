# Completion

if command -v brew > /dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        source $(brew --prefix)/etc/bash_completion
    fi
fi
