# source antidote
source ~/.config/antidote/antidote.zsh

export ANTIDOTE_HOME=~/.cache/antidote

zstyle ':antidote:bundle' file "${DOTFILES_PREFIX}/antidote/zsh_plugins.txt"
zstyle ':antidote:static' file "${DOTFILES_PREFIX}/antidote/zsh_plugins.zsh"
antidote load
