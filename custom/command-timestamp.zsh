TMOUT=86400

# Avoid resetting prompt when TMOUT is reached but we are in certain operating modes
TRAPALRM() {
  if [[ -n $TMUX && \
    $WIDGET != *"complete"* && \
    $WIDGET != *"beginning-search" && \
    $KEYMAP != "vivis" && \
    $KEYMAP != "vivli" \
  ]] && zle reset-prompt;
}

# Update the timestamp of command when it starts running
reset-prompt-and-accept-line() {
  zle reset-prompt
  zle accept-line
}
zle -N reset-prompt-and-accept-line
bindkey '^M' reset-prompt-and-accept-line
