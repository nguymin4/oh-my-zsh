## History wrapper
function omz_history {
  local clear list
  zparseopts -E c=clear l=list

  if [[ -n "$clear" ]]; then
    # if -c provided, clobber the history file
    echo -n >| "$HISTFILE"
    echo >&2 History file deleted. Reload the session to see its effects.
  elif [[ -n "$list" ]]; then
    # if -l provided, run as if calling `fc' directly
    builtin fc "$@"
  else
    # unless a number is provided, show all history events (starting from 1)
    [[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
  fi
}

# Timestamp format
case ${HIST_STAMPS-} in
  "mm/dd/yyyy") alias history='omz_history -f' ;;
  "dd.mm.yyyy") alias history='omz_history -E' ;;
  "yyyy-mm-dd") alias history='omz_history -i' ;;
  "") alias history='omz_history' ;;
  *) alias history="omz_history -t '$HIST_STAMPS'" ;;
esac

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt append_history
setopt extended_history          # Write the history file in the ":start:elapsed;command" format.
setopt hist_expire_dups_first    # Expire duplicate entries first when trimming history.
setopt hist_find_no_dups         # Do not display a line previously found.
setopt hist_ignore_all_dups      # Delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_dups          # Don't record an entry that was just recorded again.
setopt hist_ignore_space         # Ignore commands that start with space
setopt hist_reduce_blanks        # Remove superfluous blanks before recording entry.
setopt hist_save_no_dups         # Don't write duplicate entries in the history file.
setopt hist_verify               # Don't execute immediately upon history expansion.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt share_history             # Share history between all sessions.
HISTORY_IGNORE='(ls*|ll*|la*|git (br*|ll|ls|lg|la|st|diff)|vi|nvim|clear)'
