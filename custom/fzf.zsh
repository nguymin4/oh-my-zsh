set_fzf_theme() {
  local fzf_theme='light'

  if [[ -n "$1" ]]; then
    fzf_theme="$1"
  else
    if grep -Fq 'edge-dark.vim' $HOME/.vimrc; then
      fzf_theme='dark'
    fi
  fi

  export FZF_DEFAULT_OPTS="--height 25% --color=${fzf_theme},bg:-1,bg+:-1,hl:2,hl+:1,pointer:1,info:3"
}

if [ -f $HOME/.fzf.zsh ]; then
  source $HOME/.fzf.zsh
  set_fzf_theme
fi

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
