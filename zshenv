if type $EDITOR > /dev/null; then
  export GIT_EDITOR=$EDITOR
fi

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh
