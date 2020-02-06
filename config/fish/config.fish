set -x LANG en_US.UTF-8

if status is-login
  set -xp PATH $HOME/.local/bin $HOME/.cargo/bin
  set -xp CDPATH . /x
end

if status is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
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
"
set -x MAVEN_OPTS "-Xmx2g -Xshare:on -XX:TieredStopAtLevel=1 -XX:+UseParallelGC -Xverify:none"
