source-local-configuration () {
  local source=.zsh_source
  local dir=$PWD

  while [[ $dir != $HOME && $dir != / ]]; do
    if [[ -r $dir/$source ]]; then
      echo "Found .zsh_source..."
      source $dir/$source
      return
    fi
    dir=${dir:h}
  done
}

source-local-configuration

autoload -U add-zsh-hook
add-zsh-hook chpwd source-local-configuration
