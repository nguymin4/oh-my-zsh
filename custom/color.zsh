# dircolors
if whence dircolors >/dev/null; then
  eval `dircolors ~/.dircolors`
fi
zstyle ':completion:*' list-colors

# tty colors
if [ "$TERM" = "linux" ]; then
  echo -en "\e]P05D696D" #black
  echo -en "\e]P02F343F" #black
  echo -en "\e]P1E06C75" #darkred
  echo -en "\e]P298C379" #darkgreen
  echo -en "\e]P3E5C07B" #brown
  echo -en "\e]P4729FCF" #darkblue
  echo -en "\e]P5A872CF" #darkmagenta
  echo -en "\e]P6729FCF" #darkcyan
  echo -en "\e]P7EEEEEC" #lightgrey
  echo -en "\e]P82F343F" #darkgrey
  echo -en "\e]P9E06C75" #red
  echo -en "\e]PA98C379" #green
  echo -en "\e]PBE5C07B" #yellow
  echo -en "\e]PC729FCF" #blue
  echo -en "\e]PDA872CF" #magenta
  echo -en "\e]PE729FCF" #cyan
  echo -en "\e]PFA0A0A0" #white
  setterm --clear all --background black --foreground white
fi

color() {
  if [[ -z $1 ]]; then
    echo "Usage: color dark|light"
    return 1
  fi

  ALACRITTY_FILE="$HOME/.config/alacritty/alacritty.yml"
  TMUX_POWERLINE_FILE="$HOME/.config/powerline/config.json"
  if [ $1 = 'light' ]; then
    sed -i 's/opacity: .*/opacity: 1/' $ALACRITTY_FILE
    sed -i 's/^colors: \*dark/colors: *light/' $ALACRITTY_FILE
    sed -i 's/onedark/tomorrow/' $TMUX_POWERLINE_FILE
    sed -i -E '/colorschemes\//s|[a-zA-Z0-9_-]+\.vim|edge-light.vim|' ~/.vimrc
  else
    sed -i 's/opacity: .*/opacity: 0.90/' $ALACRITTY_FILE
    sed -i 's/^colors: \*light/colors: *dark/' $ALACRITTY_FILE
    sed -i 's/tomorrow/onedark/' $TMUX_POWERLINE_FILE
    sed -i -E '/colorschemes\//s|[a-zA-Z0-9_-]+\.vim|edge-dark.vim|' ~/.vimrc
  fi
  [[ -n $(pgrep tmux) ]] && tmux source-file ~/.tmux.conf
  source $ZSH_CUSTOM/fzf.zsh
}

