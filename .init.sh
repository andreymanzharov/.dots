#!/bin/bash
set -e

find . -type f -not -path './\.*' -printf '%P\n' | while read -r file
do
  link=$HOME/.$file
  if [ -f "$link" -a ! -L "$link" ]; then
    link_backup=$link.backup
    if [ -f "$link_backup" ]; then
      link_backup+=$(date %Y-%m-%d.%H-%M-%S)
    fi
    echo Backup $link
    mv "$link" "$link_backup"
  fi
  mkdir -p $(dirname "$link")
  echo Setup $link
  ln -sf "$PWD/$file" "$link"
done
