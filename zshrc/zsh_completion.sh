if command -v brew >> /dev/null
then
    export FPATH="$(brew --prefix)/share/zsh-completions:${FPATH:-}"
fi

autoload -Uz compinit
# Unfortunately i can't get this to work without ignoring "insecure directories"
# because i installed homebrew in a separate admin user
# Need to keep -i flag for now.
compinit -i

zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' menu select
zmodload -i zsh/complete
zmodload -i zsh/complist
