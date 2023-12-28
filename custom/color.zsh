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

# Change color scheme for terminal apps
ALACRITTY_FOLDER="$HOME/.config/alacritty"
ALACRITTY_FILE="$ALACRITTY_FOLDER/alacritty.toml"
TMUX_POWERLINE_FILE="$HOME/.config/powerline/config.json"


color() {
  if [[ -z $1 ]]; then
    echo "Usage: color dark|light"
    return 1
  fi

  alacritty_decoration="Full"
  if [[ "$(uname -sr)" =~ "Darwin.*" ]]; then
    alacritty_decoration="Buttonless"
  fi

  if [ "$1" = "light" ]; then
    sed -E "/decorations/s|Full|$alacritty_decoration|" $ALACRITTY_FOLDER/alacritty_tomorrow.toml > $ALACRITTY_FILE
    sed -i 's/onedark/tomorrow/' $TMUX_POWERLINE_FILE
    sed -i 's|edge-dark.vim|edge-light.vim|' ~/.vimrc
  else
    sed -E "/decorations/s|Full|$alacritty_decoration|" $ALACRITTY_FOLDER/alacritty_onedark.toml > $ALACRITTY_FILE
    sed -i 's/tomorrow/onedark/' $TMUX_POWERLINE_FILE
    sed -i 's|edge-light.vim|edge-dark.vim|' ~/.vimrc
  fi
  [[ -n $(pgrep tmux) ]] && tmux source-file ~/.tmux.conf
  source $ZSH_CUSTOM/fzf.zsh
}

# Try to setup alacritty config file if none available
if [ ! -f "$ALACRITTY_FILE" ]; then
  color dark
fi
