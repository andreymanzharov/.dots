#!/bin/zsh
set -euo pipefail

typeset -A themes
themes=(
  alacritty/catppuccin-mocha.toml     alacritty/main/catppuccin-mocha.toml
  waybar/mocha.css                    waybar/main/themes/mocha.css
  bat/themes/Catppuccin-mocha.tmTheme bat/main/Catppuccin-mocha.tmTheme
  kitty/mocha.conf                    kitty/main/themes/mocha.conf
  git/mocha.gitconfig                 delta/main/themes/mocha.gitconfig
)

for file in ${(k)themes}; do
  curl -Lso ./config/$file https://raw.githubusercontent.com/catppuccin/${themes[$file]}
done

git diff
