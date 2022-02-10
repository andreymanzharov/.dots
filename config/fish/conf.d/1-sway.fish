if status is-login
  set -l tty1 (tty)
  if test "$tty1" = "/dev/tty1"
    exec sway
  end
end
