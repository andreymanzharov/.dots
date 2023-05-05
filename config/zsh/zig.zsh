zig_update () {
  #curl -o- $(curl https://ziglang.org/download/index.json | jq  -r '.master|.["x86_64-linux"].tarball') | tar xJ
  local version tarball
  IFS=, read version tarball < <(curl -s https://ziglang.org/download/index.json | jq  -r '.master | .version + "," + .["x86_64-linux"].tarball')
  local zig_dir=~t/zig-linux-x86_64-$version
  if [ -d $zig_dir ]; then
    echo up to date: $version
    return 1
  fi
  echo update to $version
  curl -o- $tarball | tar xJ -C ~t
  local zig
  if zig=$(readlink $(which zig)); then
    local old_zig_dir=$(dirname $zig)
    if [[ $old_zig_dir/ = ~t/* ]]; then
      echo remove old $old_zig_dir
      rm -rf $old_zig_dir
    fi
  fi
  ln -sf $zig_dir/zig ~/.local/bin/zig
}

