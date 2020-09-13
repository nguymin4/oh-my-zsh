source $ZSH/plugins/fzf/fzf.plugin.zsh

export FZF_DEFAULT_OPTS='--height 25%'

if [[ $(readlink -f $HOME/.Xresources.d/urxvt/urxvt-default-theme) =~ "tomorrow" ]]
then
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=light,hl:2,hl+:1,bg+:0,gutter:0,info:3,prompt:4,pointer:1'
else
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=dark,hl:2,hl+:1,bg+:0,gutter:0,info:3,prompt:4,pointer:1'
fi

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

