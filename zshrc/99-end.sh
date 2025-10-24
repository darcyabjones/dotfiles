bindkey -e

bindkey '^[OA' up-line-or-search
bindkey '^[OB' down-line-or-search

bindkey '^R' history-incremental-search-backward

bindkey -M viins '^[[A' up-line-or-search
bindkey -M viins '^[[B' down-line-or-search
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1


if command -v tmux_create_default_session &> /dev/null
then

  if [ -z "${TMUX:-}" ]
  then
    zle -N tmux_run_default_session_create
    zle -N tmux_run_default_session_splitv
    zle -N tmux_run_default_session_splith
    bindkey '^Bc' tmux_run_default_session_create
    bindkey '^B"' tmux_run_default_session_splitv
    bindkey '^B%' tmux_run_default_session_splith
  fi
fi
