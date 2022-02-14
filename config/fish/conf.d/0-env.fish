set -x LANG en_US.UTF-8
set -xa LESS -F -X -S
set -x GIT_EDITOR $EDITOR

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
