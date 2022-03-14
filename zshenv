export TIMEFMT='
real: %E
user: %U
sys:  %S'

export GIT_EDITOR=$EDITOR

java_tool_options=()

java_tool_options_proxy() {
  local proxy=${${(P)1}_proxy}
  [[ -z $proxy ]] && return
  local parts=$(echo $proxy | grep -oP 'https?://\K([^/]*)')
  parts=(${(s/:/)parts})
  [[ -n $parts[1] ]] && java_tool_options+=-D${1}.proxyHost=$parts[1]
  [[ -n $parts[2] ]] && java_tool_options+=-D${1}.proxyPort=$parts[2]
}
java_tool_options_proxy http
java_tool_options_proxy https
unfunction java_tool_options_proxy
java_tool_options+=-Dhttp.nonProxyHosts=${no_proxy//,/|}

export JAVA_TOOL_OPTIONS=$java_tool_options

export MAVEN_HOME="/usr/local/stow/apache-maven-3.8.5"
export MAVEN_OPTS="-Xmx2g -Xshare:on -XX:+UseParallelGC"

export SERVERS_HOME=/z

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
