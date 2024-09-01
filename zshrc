# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=10000
setopt extendedglob

autoload -U promptinit; promptinit

autoload -Uz compinit
compinit

zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' menu select
zmodload -i zsh/complete
zmodload -i zsh/complist

# End of lines added by compinstall


### Paths etc
source "${HOME}/.aliases"
source "${HOME}/.env"

# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

fpath+=( "${HOME}/.dotfiles/darcy.zsh-theme" )
source "${HOME}/.dotfiles/darcy.zsh-theme"

# emacs keybindings
#bindkey '^[OA' up-line-or-search
#bindkey '^[OB' down-line-or-search
#
bindkey -e
#bindkey '^R' history-incremental-search-backward


# Vim style keybindings
#set -o vi
#bindkey -v

# Update mode change register to 0.1 sec
#export KEYTIMEOUT=1

#bindkey -M viins "^[[1;5C" forward-word
#bindkey -M viins "^[[1;5D" backward-word
#bindkey -M vicmd "^[[1;5C" forward-word
#bindkey -M vicmd "^[[1;5D" backward-word

# Re-enable default UP/Down history search

#bindkey '^R' history-incremental-search-backward

#bindkey -M viins '^[[A' up-line-or-search
#bindkey -M viins '^[[B' down-line-or-search

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${HOME}/.mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/.mambaforge/etc/profile.d/conda.sh" ]; then
        . "${HOME}/.mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/.mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
