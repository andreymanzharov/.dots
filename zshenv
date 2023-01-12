export TIMEFMT='
real: %E
user: %U
sys:  %S'

export GIT_EDITOR=$EDITOR

jdk_java_options=()

if [[ `uname -s` = Linux ]]; then
  jdk_java_options+=-Dswing.aatext=true
  jdk_java_options+=-Dawt.useSystemAAFontSettings=lcd
fi

java_tool_options_proxy() {
  local proxy=${${(P)1}_proxy}
  [[ -z $proxy ]] && return
  local parts=$(echo $proxy | grep -oP 'https?://\K([^/]*)')
  parts=(${(s/:/)parts})
  [[ -n $parts[1] ]] && jdk_java_options+=-D${1}.proxyHost=$parts[1]
  [[ -n $parts[2] ]] && jdk_java_options+=-D${1}.proxyPort=$parts[2]
}
java_tool_options_proxy http
java_tool_options_proxy https
unfunction java_tool_options_proxy

[[ -n $no_proxy ]] && jdk_java_options+=-Dhttp.nonProxyHosts=${no_proxy//,/|}

[[ ${#jdk_java_options} -gt 0 ]] && export JDK_JAVA_OPTIONS=$jdk_java_options

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
