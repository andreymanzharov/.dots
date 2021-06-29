
autoload -U add-zsh-hook

load-local-conf () {
  if [[ -r .zsh_source ]]; then
    echo "Found .zsh_source..."
    source .zsh_source
  fi
}

add-zsh-hook chpwd load-local-conf
