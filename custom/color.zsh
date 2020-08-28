# dircolors
eval `dircolors ~/.dircolors`
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
export TERM=xterm-256color

color() {
  ALACRITTY_FOLDER="$HOME/.config/alacritty"
  TMUX_POWERLINE_FOLDER="$HOME/.config/powerline/colorschemes/tmux"
  URXVT_FOLDER="$HOME/.Xresources.d/urxvt"
  VIM_FOLDER="$HOME/.vim/colorschemes"
  if [ $1 = 'light' ]; then
    sed -i 's/^colors: \*dark/colors: *light/' $ALACRITTY_FOLDER/alacritty.yml
    ln -sf $TMUX_POWERLINE_FOLDER/tomorrow.json $TMUX_POWERLINE_FOLDER/default.json
    ln -sf $URXVT_FOLDER/urxvt-tomorrow-theme $URXVT_FOLDER/urxvt-default-theme
    ln -sf $VIM_FOLDER/tomorrow.vim $VIM_FOLDER/default.vim
  else
    sed -i 's/^colors: \*light/colors: *dark/' $ALACRITTY_FOLDER/alacritty.yml
    ln -sf $TMUX_POWERLINE_FOLDER/onedark.json $TMUX_POWERLINE_FOLDER/default.json
    ln -sf $URXVT_FOLDER/urxvt-arc-theme $URXVT_FOLDER/urxvt-default-theme
    ln -sf $VIM_FOLDER/onedark.vim $VIM_FOLDER/default.vim
  fi
  [[ -n $(pgrep tmux) ]] && tmux source-file ~/.tmux.conf
  xrdb ~/.Xresources
}

