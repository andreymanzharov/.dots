source ~/.zgenom/zgenom.zsh

zgenom autoupdate

if ! zgenom saved; then
  zgenom ohmyzsh

  zgenom ohmyzsh plugins/extract
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/mercurial
  zgenom ohmyzsh plugins/sudo
  if [[ $(uname -s) = Darwin ]]; then
    zgenom ohmyzsh plugins/brew
  fi
  if [[ $(uname -s) = Linux ]]; then
    zgenom ohmyzsh plugins/systemd
    zgenom ohmyzsh plugins/tmux
  fi

  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting

  zgenom load sindresorhus/pure

  zgenom load ~/.config/zsh

  zgenom save
fi

typeset -U cdpath
cdpath=(. /x $cdpath)

BASE16_SHELL=~/.config/base16-shell
[[ -n $PS1 ]] && [[ -s $BASE16_SHELL/profile_helper.sh ]] && eval "$($BASE16_SHELL/profile_helper.sh)"

export LESS="$LESS -F -X -S -R"

if type bat > /dev/null; then
  alias b='bat'
fi

alias e=$EDITOR
if type $VISUAL > /dev/null; then
  alias ev='neovide'
fi

if type exa > /dev/null; then
  alias l='exa -lah'
  alias la='exa -lah'
  alias ll='exa -lh'
  alias ls='exa'
  alias lt='exa -lahT'
fi

alias sudo='sudo '

alias tmux='tmux -2'
alias tss="ts \ "

alias hlol='hg log -G -b .'
alias hlola='hg log -G'
