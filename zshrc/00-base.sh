# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt extendedglob

autoload -U promptinit; promptinit

autoload -Uz compinit
compinit

zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' menu select
zmodload -i zsh/complete
zmodload -i zsh/complist


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
