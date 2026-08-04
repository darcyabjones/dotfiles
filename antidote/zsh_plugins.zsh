fpath+=( "$HOME/.cache/antidote/github.com/zsh-users/zsh-completions" )
source "$HOME/.cache/antidote/github.com/zsh-users/zsh-completions/zsh-completions.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/mattmc3/zfunctions" )
source "$HOME/.cache/antidote/github.com/mattmc3/zfunctions/zfunctions.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/zsh-users/zsh-autosuggestions" )
source "$HOME/.cache/antidote/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
if ! (( $+functions[zsh-defer] )); then
  fpath+=( "$HOME/.cache/antidote/github.com/romkatv/zsh-defer" )
  source "$HOME/.cache/antidote/github.com/romkatv/zsh-defer/zsh-defer.plugin.zsh"
fi
fpath+=( "$HOME/.cache/antidote/github.com/zdharma-continuum/fast-syntax-highlighting" )
zsh-defer source "$HOME/.cache/antidote/github.com/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/zsh-users/zsh-history-substring-search" )
source "$HOME/.cache/antidote/github.com/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/belak/zsh-utils/editor" )
source "$HOME/.cache/antidote/github.com/belak/zsh-utils/editor/editor.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/belak/zsh-utils/utility" )
source "$HOME/.cache/antidote/github.com/belak/zsh-utils/utility/utility.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/belak/zsh-utils/history" )
source "$HOME/.cache/antidote/github.com/belak/zsh-utils/history/history.plugin.zsh"
fpath+=( "$HOME/.cache/antidote/github.com/belak/zsh-utils/completion" )
source "$HOME/.cache/antidote/github.com/belak/zsh-utils/completion/completion.plugin.zsh"
