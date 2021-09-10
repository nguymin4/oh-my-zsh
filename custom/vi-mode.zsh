#######################################
#### Settings from plugins/vi-mode ####
#######################################
bindkey -v

# allow vv to edit the command line (standard behaviour)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

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

if [[ -z "${VI_MODE_DISABLE_CLIPBOARD:-}" ]]; then
  wrap_clipboard_widgets copy \
      vi-yank vi-yank-eol vi-yank-whole-line \
      vi-change vi-change-eol vi-change-whole-line \
      vi-kill-line vi-kill-eol vi-backward-kill-word \
      vi-delete vi-delete-char vi-backward-delete-char

  wrap_clipboard_widgets paste \
      vi-put-{before,after} \
      put-replace-selection

  unfunction wrap_clipboard_widgets
fi

###########################
##### Custom settings #####
###########################

# High timeout lead to delay when changing mode
KEYTIMEOUT=5

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
