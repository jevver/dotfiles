#!/usr/bin/env zsh

setopt all_export
setopt always_to_end
setopt append_history
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history
setopt menu_complete
setopt pushd_ignore_dups
setopt pushd_minus

set -o vi

source "$HOME/.config/zsh/env"

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' fzf-search-display true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' verbose true

autoload -Uz compinit
compinit

source $(brew --prefix)/etc/profile.d/z.sh
eval "$(fnm env)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.zsh_plugins

zmodload zsh/complist

bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey 'ç' fzf-cd-widget
bindkey '^l' autosuggest-accept
bindkey '^[[Z' reverse-menu-complete
bindkey '^Z' ctrl-z
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

source "$HOME/.config/zsh/aliases"
source "$HOME/Documents/Dotfiles/zsh"
source "$HOME/.config/zsh/functions"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh"; then source "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh"; fi
# END_KITTY_SHELL_INTEGRATION
