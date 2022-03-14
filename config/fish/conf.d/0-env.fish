set -x LANG en_US.UTF-8
set -xa LESS -F -X -S
set -x GIT_EDITOR $EDITOR

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

set -x JAVA_HOME /etc/java-config-2/current-system-vm

set -x JAVA_TOOL_OPTIONS
set -xa JAVA_TOOL_OPTIONS -Dawt.useSystemAAFontSettings=gasp

function __java_opts_append_proxy -a schema url
  echo $url | grep -oP 'https?://\K([^/]*)' | read -d ':' -l host port
  if test -n $host
    set -xa JAVA_TOOL_OPTIONS -D$schema.proxyHost=$host
  end
  if test -n $port
    set -xa JAVA_TOOL_OPTIONS -D$schema.proxyPort=$port
  end
end

function __java_opts_append_non_proxy
  set -l non_proxy (string replace -a , \| $no_proxy)
  if test -n $non_proxy
    set -xa JAVA_TOOL_OPTIONS -Dhttp.nonProxyHosts=\"$non_proxy\"
  end
end

__java_opts_append_proxy http $http_proxy
__java_opts_append_proxy https $https_proxy
__java_opts_append_non_proxy
