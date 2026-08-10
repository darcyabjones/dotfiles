# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${HOME}/.conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/.conda/etc/profile.d/conda.sh" ]; then
        . "${HOME}/.conda/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/.conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

__mamba_setup="$("${HOME}/.conda/bin/mamba" shell hook --shell zsh 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="${HOME}/.conda/bin/mamba"  # Fallback on help from mamba activate
fi
unset __mamba_setup
