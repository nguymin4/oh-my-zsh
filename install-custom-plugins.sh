#!/bin/bash

DIR=${ZSH_CUSTOM:-./custom}

install() {
  plugin_name=$(echo "$1" | cut -d / -f2)
  plugin_dir=$DIR/plugins/$plugin_name

  if [[ ! -d $plugin_dir ]];
  then
    echo "Cloning $1 to $plugin_dir..."
    git clone "https://github.com/${1}.git" "$plugin_dir"
  else
    echo "Updating $1 at $plugin_dir..."
    cd "$plugin_dir" && git pull
    cd "$DIR" || return
  fi
}

plugins=(
"esc/conda-zsh-completion"
"nguymin4/zsh-vimode-visual"
"zsh-users/zsh-syntax-highlighting"
)

for plugin in "${plugins[@]}"; do install "$plugin" & done
wait
