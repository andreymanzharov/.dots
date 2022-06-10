typeset -U path
path=(~/.cargo/bin ~/.local/bin ~/go/bin $path)

if [[ `uname -s` = Linux && `tty` = /dev/tty1 ]]; then
  export XDG_CURRENT_DESKTOP=sway
  export MOZ_ENABLE_WAYLAND=1
  export QT_QPA_PLATFORM=wayland
  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  export _JAVA_AWT_WM_NONREPARENTING=1

  exec sway
fi
