# vim:ft=zsh ts=2 sw=2 sts=2
# Based on the great ys theme (http://ysmood.org/wp/2013/03/my-ys-terminal-theme/)

# Machine name.
function box_name {
  [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%} on %{$fg[cyan]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✖︎"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}● "

# Based on http://stackoverflow.com/a/32164707/3859566
function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%dd ' $D
  [[ $H > 0 ]] && printf '%dh ' $H
  [[ $M > 0 ]] && printf '%dm ' $M
  printf '%ds' $S
}

if [ ! -n "${HONUKAI_EXEC_TIME_ELAPSED+1}" ]; then
  HONUKAI_EXEC_TIME_ELAPSED=5
fi

prompt_cmd_exec_time() {
  [[ $HONUKAI_last_exec_duration -gt $HONUKAI_EXEC_TIME_ELAPSED ]] && echo "-  $(displaytime $HONUKAI_last_exec_duration) "
}

vi_mode_prompt_info() {
  ARROW=''
  case ${KEYMAP} in
    (vicmd)  VI_MODE="\
%{$bg[green]%}%{$fg[black]%} NORMAL %{$reset_color%}\
%{$fg[green]%}$ARROW%{$reset_color%}%{$reset_color%} " ;;
    (main|viins)  VI_MODE="\
%{$bg[blue]%}$FG[255] INSERT %{$reset_color%}\
%{$fg[blue]%}$ARROW%{$reset_color%} " ;;
    (vivis)  VI_MODE="\
%{$bg[magenta]%}$FG[255] VISUAL %{$reset_color%}\
%{$fg[magenta]%}$ARROW%{$reset_color%} " ;;
    (vivli)  VI_MODE="\
%{$bg[magenta]%}$FG[255] V-LINE %{$reset_color%}\
%{$fg[magenta]%}$ARROW%{$reset_color%} " ;;
    (*)  VI_MODE="\
%{$bg[blue]%}$FG[255] INSERT %{$reset_color%}\
%{$fg[blue]%}$ARROW%{$reset_color%} " ;;
  esac
  echo $VI_MODE
}

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
build_prompt() {
  VI_MODE='$(vi_mode_prompt_info)'
  ARROW="%{$fg[green]%}→ %{$reset_color%}"

  PROMPT="
%{$fg[green]%}%n@\
%{$fg[green]%}$(box_name) \
%{$fg[yellow]%}${current_dir}%{$reset_color%}\
${git_info} \
%f[%*] \
%{$fg[yellow]%}$(prompt_cmd_exec_time)
${VI_MODE}\
${ARROW}";

  if [[ "$USER" == "root" ]]; then
    PROMPT="
%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%} \
%{$fg[green]%}@\
%{$fg[green]%}$(box_name) \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%} \
${git_info} \
%f[%*] \
%{$fg[yellow]%}$(prompt_cmd_exec_time)
${VI_MODE}\
${ARROW}";
  fi
}

# Prompt previous command execution time
preexec() {
  cmd_timestamp=`date +%s`
}

precmd() {
  local stop=`date +%s`
  local start=${cmd_timestamp:-$stop}
  let HONUKAI_last_exec_duration=$stop-$start
  cmd_timestamp=''
  build_prompt
}
