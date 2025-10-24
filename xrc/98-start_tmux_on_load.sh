if [ -n "${SSH_TTY}" ]
then
    TMUX_DEFAULT_SESSIONNAME="$(whoami)"
else
    TMUX_DEFAULT_SESSIONNAME="default"
fi

AUTOSTART_TMUX=false
AUTOCREATE_TMUX=true

tmux_check_default_session_exists() {
  tmux has-session -t "${TMUX_DEFAULT_SESSIONNAME}" &>/dev/null
}

tmux_create_default_session() {
  if ! command -v tmux &> /dev/null
  then
    echo "ERROR: you don't have tmux on your PATH" >&2
    return 1
  fi

  if ! tmux_check_default_session_exists
  then
    tmux new-session -d -s "${TMUX_DEFAULT_SESSIONNAME}" &>/dev/null
  fi
}

_tmp_write_session_history() {
    HISTFILE="${TMPDIR:/tmp}/$$-$(date +%s).zsh_history"
    fc -W
    echo "${HISTFILE}"
}

tmux_run_default_session() {
  if [ -z "${TMUX:-}" ]
  then
    tmux_create_default_session
    tmux attach-session -t "${TMUX_DEFAULT_SESSIONNAME}"
  fi
}

tmux_run_default_session_widget() {
    exec </dev/tty
    exec <&1
    tmux_run_default_session
}

# It seems too hard to save any user defined variables or functions and re-load them.
# Maybe in the future. set, export -p, declare -p, delcare -f, seem to have the answers.

tmux_run_default_session_create() {
  if [ -z "${TMUX:-}" ]
  then
    IS_NEW=$(tmux_check_default_session_exists && echo false || echo true)
    tmux_create_default_session
    NEW_HISTFILE="$(_tmp_write_session_history)"

    if [ ! "${IS_NEW}" = "true" ]
    then
      tmux new-window -t "${TMUX_DEFAULT_SESSIONNAME}"
    fi
    tmux send-keys -t "${TMUX_DEFAULT_SESSIONNAME}" \
        "cd '${PWD}'; HISTFILE='${NEW_HISTFILE}' fc -R &> /dev/null; rm -f '${NEW_HISTFILE}'; export HISTFILE='${HISTFILE}'; clear" Enter

    tmux_run_default_session_widget
  fi
}

tmux_run_default_session_split() {
  DIRECTION="${1:-horizontal}"
  if [ -z "${TMUX:-}" ]
  then
    IS_NEW=$(tmux_check_default_session_exists && echo false || echo true)
    tmux_create_default_session
    NEW_HISTFILE="$(_tmp_write_session_history)"
    if [ ! "${IS_NEW}" = "true" ]
    then
      tmux new-window -t "${TMUX_DEFAULT_SESSIONNAME}"
    fi

    tmux send-keys -t "${TMUX_DEFAULT_SESSIONNAME}" \
        "cd '${PWD}'; HISTFILE='${NEW_HISTFILE}' fc -R &> /dev/null; rm -f '${NEW_HISTFILE}'; export HISTFILE='${HISTFILE}'; clear" Enter

    if [ "${DIRECTION}" = "horizontal" ]
    then
        tmux split-window -t "${TMUX_DEFAULT_SESSIONNAME}" -h
    else
        tmux split-window -t "${TMUX_DEFAULT_SESSIONNAME}" -v
    fi

    tmux_run_default_session_widget
  fi
}

tmux_run_default_session_splith() {
    tmux_run_default_session_split "horizontal"
}

tmux_run_default_session_splitv() {
    tmux_run_default_session_split "vertical"
}

tmux_autostart_default_session() {
  if [ -z "${TMUX:-}" ]
  then
    tmux_create_default_session
    exec tmux attach-session -t "${TMUX_DEFAULT_SESSIONNAME}"
  fi
}
