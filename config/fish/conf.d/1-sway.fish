if status is-login
  set -l tty1 (tty)
  if test "$tty1" = "/dev/tty1"
    set -x MOZ_ENABLE_WAYLAND 1
    set -x QT_QPA_PLATFORM wayland
    set -x QT_WAYLAND_DISABLE_WINDOWDECORATION 1
    set -x _JAVA_AWT_WM_NONREPARENTING 1
    exec sway
  end
end
