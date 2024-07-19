if [ -f $HOME/.fzf.zsh ]; then
  source $HOME/.fzf.zsh

  COLOR_BG='dark'
  if ! grep -Fq 'colors: *dark' $HOME/.config/alacritty/alacritty.yml; then
    COLOR_BG='light'
  fi

  export FZF_DEFAULT_OPTS='--height 25%'
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" --color=${COLOR_BG},hl:2,hl+:1,bg+:0,gutter:0,info:3,prompt:4,pointer:1"
fi

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
