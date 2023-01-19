vim_pack_update () {
  local git_dir
  for git_dir in $HOME/.vim/pack/**/.git(/)
  do
    echo $fg[yellow]$git_dir:h$reset_color
    git -C $git_dir:h pull --autostash --prune || break
  done
}
