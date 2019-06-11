set -x LANG en_US.UTF-8
set -x PATH $HOME/.local/bin $HOME/.cargo/bin $PATH

set -x LESS "$LESS -F -X -S"

set -x HG_LOG_TEMPLATE "{label('yellow', rev)} {label('red', shortest(node, 6))} -{label('yellow', ifeq(branch, 'default', '', ' {branch}'))}{label('yellow', if(tags, ' (tags: {join(tags, ', ')})'))}{label('yellow', if(bookmarks, ' [bookmarks: {join(bookmarks, ', ')}]'))} {desc|strip|firstline} {label('green', '({date|age})')} {label('blue', '<{author|person}>')}\n"
