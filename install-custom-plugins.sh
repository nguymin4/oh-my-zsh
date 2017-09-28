#!/bin/bash

DIR=${ZSH_CUSTOM:-./custom}

install() {
  IFS='\/' read -r -a parts < <(echo $1)
  plugin_dir=$DIR/plugins/${parts[1]}

  if [[ ! -d $plugin_dir ]];
  then
    git clone git://github.com/$1 $plugin_dir
  else
    cd $plugin_dir && git pull
    cd $DIR
  fi
}

plugins=(
"zsh-users/zsh-autosuggestions"
"zsh-users/zsh-syntax-highlighting"
"nguymin4/zsh-vimode-visual"
"mafredri/zsh-async"
)

for plugin in "${plugins[@]}"; do install $plugin & done
wait

