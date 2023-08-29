typeset -U path
path=(~/.cargo/bin ~/.nimble/bin ~/.local/bin ~/.local/lib64/node-modules/bin ~/go/bin $path)

if [[ `uname -s` = Linux && `tty` = /dev/tty1 ]]; then
  export XDG_CURRENT_DESKTOP=sway
  export MOZ_ENABLE_WAYLAND=1
  export QT_QPA_PLATFORM=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1

  exec dbus-run-session sway
fi
