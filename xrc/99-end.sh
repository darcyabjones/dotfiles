if [ "${AUTOCREATE_TMUX:-false}" = "true" ]
then
  tmux_start_default_session
fi

# This command must be at the very end to work properly
if [ "${AUTOSTART_TMUX:-false}" = "true" ]
then
  tmux_autostart_default_session
fi
