source ~/.zgenom/zgenom.zsh

zgenom autoupdate

if ! zgenom saved; then
  zgenom ohmyzsh

  zgenom ohmyzsh plugins/asdf
  zgenom ohmyzsh plugins/dirhistory
  zgenom ohmyzsh plugins/extract
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/mercurial
  zgenom ohmyzsh plugins/sudo
  if [[ $(uname -s) = Darwin ]]; then
    zgenom ohmyzsh plugins/brew
  fi
  if [[ $(uname -s) = Linux ]]; then
    zgenom ohmyzsh plugins/ssh-agent
    zgenom ohmyzsh plugins/systemd
    zgenom ohmyzsh plugins/tmux
  fi

  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting

  zgenom load sindresorhus/pure

  zgenom load ~/.config/zsh

  zgenom save
fi

typeset -U PATH path

export LESS="$LESS -F -X -S -R"

if type bat > /dev/null; then
  alias b='bat'
fi

alias e=${EDITOR:-nvim}
if type $VISUAL > /dev/null; then
  alias ev=$VISUAL
elif type neovide > /dev/null; then
  alias ev=neovide
fi

if type eza > /dev/null; then
  alias l='eza -lah'
  alias la='eza -lah'
  alias ll='eza -lh'
  alias ls='eza'
  alias lt='eza -lahT'
fi

alias sudo='sudo '

alias tmux='tmux -2'
alias tss="ts \ "

alias hlol='hg log -G -b .'
alias hlola='hg log -G'

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi
