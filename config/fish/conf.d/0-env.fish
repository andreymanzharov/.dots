if status is-login
  set -x LANG en_US.UTF-8

  set -xp PATH $HOME/.local/bin $HOME/.cargo/bin

  set -xa LESS -F -X -S

  set -x MOZ_ENABLE_WAYLAND 1
  set -x QT_QPA_PLATFORM wayland
  set -x QT_WAYLAND_DISABLE_WINDOWDECORATION 1
  set -x _JAVA_AWT_WM_NONREPARENTING 1

  set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

  set -x GIT_EDITOR $EDITOR
end
