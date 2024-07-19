source $ZSH/plugins/vi-mode/vi-mode.plugin.zsh
source $ZSH_CUSTOM/plugins/zsh-vimode-visual/zsh-vimode-visual.plugin.zsh

VIMODE_VISUAL_HIGHLIGHT='bg=yellow,fg=white'
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE='true'

# zsh vi mode
vibindkey() {
  bindkey -M viins "$@"
  bindkey -M vicmd "$@"
}

# Improve history bindings
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
vibindkey "^[OA" up-line-or-beginning-search # Up
vibindkey "^[[A" up-line-or-beginning-search # Up
vibindkey "^N" up-line-or-beginning-search # Up
vibindkey "^[OB" down-line-or-beginning-search # Down
vibindkey "^[[B" down-line-or-beginning-search # Down
vibindkey "^P" down-line-or-beginning-search # Down
bindkey -M vicmd -r 'j'
bindkey -M vicmd -r 'k'
bindkey -M viins "^[f" forward-word
bindkey -M viins "^[b" backward-word

# Make HOME, END work normally instead of capitalize
vibindkey "${terminfo[khome]}" beginning-of-line
vibindkey "${terminfo[kend]}" end-of-line
vibindkey "^[[1~" beginning-of-line
vibindkey "^[[4~" end-of-line

# Set INSERT as default mode for zsh vi-mode
zle-line-init() { zle -K viins }
zle -N zle-line-init

# Enable Shift-Tab
# bindkey -M menuselect '^[[Z' reverse-menu-complete
