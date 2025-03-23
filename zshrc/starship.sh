if command -v starship > /dev/null
then
    export STARSHIP_CONFIG="${DOTFILES_PREFIX}/starship.toml"
    eval "$(starship init zsh)"
fi
