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
"nguymin4/pure"
)

for plugin in "${plugins[@]}"; do install "$plugin" & done
wait
