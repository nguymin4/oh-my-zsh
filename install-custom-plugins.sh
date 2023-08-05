#!/bin/bash

DIR=${ZSH_CUSTOM:-./custom}

install() {
  IFS='\/' read -r -a parts < <(echo $1)
  plugin_dir=$DIR/plugins/${parts[1]}

  if [[ ! -d $plugin_dir ]];
  then
    echo "Cloning $1 ..."
    git clone https://github.com/$1 $plugin_dir
  else
    echo "Updating $1 ..."
    cd $plugin_dir && git pull
    cd $DIR
  fi
}

plugins=(
"esc/conda-zsh-completion"
"nguymin4/pure"
"nguymin4/zsh-vimode-visual"
"zsh-users/zsh-syntax-highlighting"
)

for plugin in "${plugins[@]}"; do install $plugin & done
wait

