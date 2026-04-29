# Exportxs
export XDG_CONFIG_HOME="$HOME"/.config
export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export SSH_AUTH_SOCK="$XDG_CONFIG_HOME"/1Password/agent.sock

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Source
[ -f ~/.alias ]        && source ~/.alias
[ -f ~/.secret_alias ] && source ~/.secret_alias
[ -f ~/.env ]          && source ~/.env
[ -f ~/.secret_env ]   && source ~/.secret_env

[ -f ~/.config/zsh/git-prompt.zsh ] && source ~/.config/zsh/git-prompt.zsh

# Eval
eval "$(zoxide init --cmd cd zsh)"
eval "$(direnv hook zsh)"

# ~~~~~ Vi Mode ~~~~~ #

bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

precmd_functions+=(_aws_rprompt)
function _aws_rprompt() {
  if [[ -n "$AWS_PROFILE" ]]; then
    if [[ "$AWS_PROFILE_COLOR" == "red" ]]; then
      RPROMPT="%F{red}AWS: ${AWS_PROFILE}%f"
    else
      RPROMPT="%F{green}AWS: ${AWS_PROFILE}%f"
    fi
  else
    RPROMPT=""
  fi
}

# Auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files

# Command History
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char

# edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# ~~~~~ Completion ~~~~~ #

eval "$(op completion zsh)"; compdef _op op
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terragrunt terragrunt
