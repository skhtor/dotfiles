# Exports
export XDG_CONFIG_HOME="$HOME"/.config
export PATH="$HOME/.local/bin:$PATH"
export SSH_AUTH_SOCK="$XDG_CONFIG_HOME"/1Password/agent.sock

# Source
[ -f ~/.alias ]        && source ~/.alias
[ -f ~/.secret_alias ] && source ~/.secret_alias
[ -f ~/.env ]          && source ~/.env
[ -f ~/.secret_env ]   && source ~/.secret_env

[ -f ~/.config/zsh/git-prompt.zsh ] && source ~/.config/zsh/git-prompt.zsh
[ -f ~/.config/zsh/.fzf.zsh ]       && source ~/.config/zsh/.fzf.zsh

# Eval
eval "$(zoxide init --cmd cd zsh)"

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

# Must be at end of .zshrc
# See: https://github.com/zsh-users/zsh-syntax-highlighting?tab=readme-ov-file#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terragrunt terragrunt
