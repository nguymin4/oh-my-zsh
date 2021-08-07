precmd() {
  zmodload zsh/zprof
}

zle-line-init() {
  zprof
}

# link the zle-line-init widget to the function of the same name
zle -N zle-line-init
