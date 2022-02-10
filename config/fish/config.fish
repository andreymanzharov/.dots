set -l os (uname)

if status is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"

  abbr --add --global e vi
  if test -n "$VISUAL"
    abbr --add --global ev $VISUAL
  end

  abbr --add --global gbsup git branch --set-upstream-to=origin/\(git-current-branch\)
  abbr --add --global gc git commit -v
  abbr --add --global gca git commit -v -a
  abbr --add --global gcam git commit -v -a -m
  abbr --add --global gd git diff
  abbr --add --global gds git diff --staged
  abbr --add --global gfa git fetch --all --prune --jobs=10
  abbr --add --global glol git log --graph --pretty='\'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\''
  abbr --add --global glola git log --graph --pretty='\'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\'' --all
  abbr --add --global gp git push
  abbr --add --global gpsup git push --set-upstream origin \(git-current-branch\)
  abbr --add --global gupa git pull --rebase --autostash -v
  abbr --add --global gst git status

  abbr --add --global hlol hg log --graph --branch . --branch default
  abbr --add --global hlola hg log --graph

  abbr --add --global hgc hg commit
  abbr --add --global hgd hg diff
  abbr --add --global hgi hg incoming
  abbr --add --global hgl hg pull --update
  abbr --add --global hgo hg outgoing --branch .
  abbr --add --global hgp hg push --branch .
  abbr --add --global hgs hg status

  abbr --add --global l exa -lah
  abbr --add --global la exa -lah
  abbr --add --global ls exa -lh

  abbr --add --global md mkdir -p

  function take
    mkdir -p $argv; and cd $argv
  end

  if test "$os" = "Darwin"
    abbr --add --global bubu brew update\; and brew outdated\; and brew upgrade\; and brew cleanup
  end
end
