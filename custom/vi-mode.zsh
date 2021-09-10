source $ZSH_CUSTOM/plugins/zsh-vimode-visual/zsh-vimode-visual.plugin.zsh

VIMODE_VISUAL_HIGHTLIGHT='bg=yellow,fg=white'

# Keybindings from vi-mode plugin
bindkey -v

# allow vv to edit the command line (standard behaviour)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-r and ctrl-s to search the history
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

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

# Enable zsh surround
# Reduce delay when change vi to NORMAL MODE
# Cannot be lower because the surround bindings
# ds, cs, ys will not work
# export KEYTIMEOUT=25
export KEYTIMEOUT=5

# autoload -Uz surround
# zle -N delete-surround surround
# zle -N add-surround surround
# zle -N change-surround surround
# bindkey -a cs change-surround
# bindkey -a ds delete-surround
# bindkey -a ys add-surround
# bindkey -M visual S add-surround

# Set INSERT as default mode for zsh vi-mode
zle-line-init() { zle -K viins }
zle -N zle-line-init

function wrap_clipboard_widgets() {
  # NB: Assume we are the first wrapper and that we only wrap native widgets
  # See zsh-autosuggestions.zsh for a more generic and more robust wrapper
  local verb="$1"
  shift

  local widget
  local wrapped_name
  for widget in "$@"; do
    wrapped_name="_zsh-vi-${verb}-${widget}"
    if [ "${verb}" = copy ]; then
      eval "
        function ${wrapped_name}() {
          zle .${widget}
          printf %s \"\${CUTBUFFER}\" | clipcopy 2>/dev/null || true
        }
      "
    else
      eval "
        function ${wrapped_name}() {
          CUTBUFFER=\"\$(clippaste 2>/dev/null || echo \$CUTBUFFER)\"
          zle .${widget}
        }
      "
    fi
    zle -N "${widget}" "${wrapped_name}"
  done
}

wrap_clipboard_widgets copy vi-yank vi-yank-eol vi-backward-kill-word vi-change-whole-line vi-delete
wrap_clipboard_widgets paste vi-put-{before,after}
unfunction wrap_clipboard_widgets
