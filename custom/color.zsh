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

# Utility function to change color scheme for terminal apps
theme() {
  local next_theme=$1
  case $next_theme in
    dark|light) ;;
    *)
      echo "Usage: theme dark|light"
      return 1
      ;;
  esac

  local prev_theme=$([ "$next_theme" = "light" ] && echo "dark" || echo "light")
  ( set_alacritty_theme $next_theme $prev_theme & )
  ( set_wezterm_theme $next_theme $prev_theme & )
  ( set_nvim_theme $next_theme $prev_theme & )
  ( set_tmux_theme $next_theme $prev_theme & )
  set_fzf_theme $next_theme
}

set_alacritty_theme() {
  local next_theme_file="alacritty_${1}.toml"
  local prev_theme_file="alacritty_${2}.toml"

  local alacritty_folder="$HOME/.config/alacritty"
  sed -i "s|$prev_theme_file|$next_theme_file|" "$alacritty_folder/alacritty.toml"
}

set_nvim_theme() {
  local next_theme_file="edge-${1}.vim"
  local prev_theme_file="edge-${2}.vim"

  sed -i "s|$prev_theme_file|$next_theme_file|" ~/.vimrc
  local vim_cmd="<C-\\><C-n>:silent! source ~/.vim/colorschemes/$next_theme_file<CR>:<Esc>"
  for server in $(find /tmp/ -maxdepth 1 -name 'nvim.*.pipe'); do
    nvim --server $server --remote-send $vim_cmd >/dev/null 2>&1
  done
}

set_tmux_theme() {
  sed -i "/tmux_theme/s|$2|$1|" ~/.tmux.conf
  [[ -n $(pgrep tmux) ]] && tmux source-file ~/.tmux.conf
}

set_wezterm_theme() {
  local next_theme="${1}_theme"
  local prev_theme="${2}_theme"

  local wezterm_config_file="$HOME/.config/wezterm/wezterm.lua"
  sed -i "/local current_theme/s|$prev_theme|$next_theme|" $wezterm_config_file
}
