source ~/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

zplug "lib/clipboard", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh

zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/mercurial", from:oh-my-zsh
zplug "plugins/pass", from:oh-my-zsh, if:"[[ $OSTYPE == *linux* ]]"
zplug "plugins/systemd", from:oh-my-zsh, if:"[[ $OSTYPE == *linux* ]]"
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:'pure.zsh', from:github, as:theme

zplug "~/.config/zsh", from:local, use:'*.zsh'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

setopt auto_cd

typeset -U path
path=(~/.cargo/bin ~/.local/bin ~/go/bin $path[@])
typeset -U cdpath
cdpath=(. /x $cdpath[@])

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
export LESS="$LESS -F -X -S"

if type "bat" > /dev/null; then
  alias b="bat"
fi

alias e="$EDITOR"
if type "$VISUAL" > /dev/null; then
  alias ev="$VISUAL"
fi

if type "exa" > /dev/null; then
  alias l="exa -lah"
  alias la="exa -lah"
  alias ll="exa -lh"
  alias ls="exa"
  alias lsa="exa -lah"
fi

alias sudo="sudo "

alias tmux="tmux -2"
alias tss="ts \ "

alias hlol="hg log -G -b ."
alias hlola="hg log -G"

