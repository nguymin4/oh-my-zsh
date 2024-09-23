_goenv-set-path() {
  if [[ -n $GOROOT ]]; then
    export PATH="$GOROOT/bin:$PATH"
  fi
  if [[ -n $GOPATH ]]; then
    export PATH="$PATH:$GOPATH/bin"
  fi
}

_goenv-unset-path() {
  if [[ -n $GOPATH ]]; then
    export PATH=${PATH/$GOPATH\/bin/}
  fi
  if [[ -n $GOROOT ]]; then
    export PATH=${PATH/$GOROOT\/bin/}
  fi

  # Clean up repeated, trailing and leading colons (:) in PATH
  PATH=$(echo "$PATH" | sed -e 's/:\{2,\}/:/g;s/^://;s/:$//')
  export PATH
}

goenv-deactivate() {
  # Always unset PATH first
  _goenv-unset-path
  unset GOROOT
  unset GOPATH
}

goenv-activate() {
  local next_version=$1
  if [[ -z $next_version ]]; then
    next_version=$(goenv version-name)
  else
    # Check and resolve version e.g. 1.22 -> 1.22.4
    next_version=$(goenv installed "$next_version")
  fi

  if [[ "$next_version" == "system" ]]; then
    goenv-deactivate
  else
    _goenv-unset-path
    export GOROOT="$GOENV_ROOT/versions/$next_version"
    export GOPATH="$HOME/go/$next_version"
    _goenv-set-path
  fi
}
