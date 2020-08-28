# Need for clock
ZSH_TIME=24
TMOUT=86400
TRAPALRM() {
  if [[ -n $TMUX && \
    $WIDGET != *"complete"* && \
    $WIDGET != *"beginning-search" && \
    $KEYMAP != "vivis" && \
    $KEYMAP != "vivli" \
  ]] && zle reset-prompt;
}

# Update the timestamp of command when it start running
reset-prompt-and-accept-line() {
  zle reset-prompt
  zle accept-line
}
zle -N reset-prompt-and-accept-line
bindkey '^M' reset-prompt-and-accept-line


