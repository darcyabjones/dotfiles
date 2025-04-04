#!/usr/bin/env bash

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if command -v brew >> /dev/null
    then
        if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
        then
            source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
        else
            for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
            do
                [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
            done
        fi
    elif [ -f "/usr/share/bash-completion/bash_completion" ]
    then
        . "/usr/share/bash-completion/bash_completion"
    elif [ -f "/etc/bash_completion" ]
    then
        . "/etc/bash_completion"
    fi
fi

if command -v brew >> /dev/null
then
    if [ -s "$(brew --prefix nvm)/nvm.sh" ]
    then
      . "$(brew --prefix nvm)/nvm.sh"
      . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
    fi
fi
