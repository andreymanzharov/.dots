#!/bin/zsh
set -euo pipefail

typeset -A themes
themes=(
  alacritty/catppuccin-mocha.toml      alacritty/main/catppuccin-mocha.toml
  waybar/mocha.css                     waybar/main/themes/mocha.css
  bat/themes/Catppuccin\ Mocha.tmTheme bat/main/themes/Catppuccin%20Mocha.tmTheme
  kitty/mocha.conf                     kitty/main/themes/mocha.conf
  git/catppuccin.gitconfig             delta/main/catppuccin.gitconfig
)

for file in ${(k)themes}; do
  curl -Lso ./config/$file https://raw.githubusercontent.com/catppuccin/${themes[$file]}
done

git diff
