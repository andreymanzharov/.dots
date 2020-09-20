set -x LANG en_US.UTF-8

if status is-login
  set -xp PATH $HOME/.local/bin $HOME/.cargo/bin
  set -xp CDPATH . /x
end

if status is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"

  abbr --add --global e vi
  if test -n "$VISUAL"
    abbr --add --global ev $VISUAL
  end

  abbr --add --global ga git add
  abbr --add --global ga. git add .
  abbr --add --global gbsup git branch --set-upstream-to=origin/\(git-current-branch\)
  abbr --add --global gc git commit -v
  abbr --add --global gca git commit -v -a
  abbr --add --global gcam git commit -v -a -m
  abbr --add --global gcb git checkout -b
  abbr --add --global gco git checkout
  abbr --add --global gd git diff
  abbr --add --global gds git diff --staged
  abbr --add --global gl git pull
  abbr --add --global glol git log --graph --pretty='\'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\''
  abbr --add --global glola git log --graph --pretty='\'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\'' --all
  abbr --add --global gp git push
  abbr --add --global gpsup git push --set-upstream origin \(git-current-branch\)
  abbr --add --global gup git pull --rebase -v
  abbr --add --global gupa git pull --rebase --autostash -v
  abbr --add --global grm git rm
  abbr --add --global gst git status
  abbr --add --global hlol hg log -GT\$HG_LOG_TEMPLATE -b.
  abbr --add --global hlola hg log -GT\$HG_LOG_TEMPLATE

  abbr --add --global hgc hg commit
  abbr --add --global hgd hg diff
  abbr --add --global hgi hg incoming
  abbr --add --global hgl hg pull -u
  abbr --add --global hglr hg pull --rebase
  abbr --add --global hgo hg outgoing
  abbr --add --global hgp hg push
  abbr --add --global hgs hg status

  abbr --add --global l exa -la
  abbr --add --global ls exa
  abbr --add --global ll exa -l
  abbr --add --global la exa -la

  abbr --add --global md mkdir -p

  abbr --add --global ts tmux new-session -s
  abbr --add --global tss tmux new-session -s _
  abbr --add --global ta tmux attach-session -t
end

set -x LESS "$LESS -F -X -S"

set -x HG_LOG_TEMPLATE "\
{label('yellow', rev)} \
{label('red', shortest(node, 6))} \
-{label('yellow', ifeq(branch, 'default', '', ' {branch}'))}\
{label('yellow', if(tags, ' (tags: {join(tags, ', ')})'))}\
{label('yellow', if(bookmarks, ' [bookmarks: {join(bookmarks, ', ')}]'))} \
{desc|strip|firstline} \
{label('green', '({date|age})')} \
{label('blue', '<{author|person}>')}\n"

set -l os (uname)
if test "$os" = "Linux"
  if set -l domain (hostname -d)
    if test "$domain" = "krista.ru"
      set -x JAVA_OPTS "\
      -Dhttp.nonProxyHosts=\"localhost|127.0.*|10.0.*|172.17.*|172.20.*|178.218.42.94|192.168.*|*.krista.ru\" \
      -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=3128 \
      -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=3128 \
      "
    end
  end
end
set -x MAVEN_OPTS "-Xmx2g -Xshare:on -XX:TieredStopAtLevel=1 -XX:+UseParallelGC -Xverify:none"
