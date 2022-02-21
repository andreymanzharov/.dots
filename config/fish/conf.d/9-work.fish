set -x SERVERS_HOME /z

set -x JAVA_HOME /etc/java-config-2/current-system-vm
set -x JAVA_OPTS

function __java_opts_append_proxy -a schema url
  echo $url | grep -oP 'https?://\K([^/]*)' | read -d ':' -l host port
  if test -n $host
    set -xa JAVA_OPTS -D$schema.proxyHost=$host
  end
  if test -n $port
    set -xa JAVA_OPTS -D$schema.proxyPort=$port
  end
end

function __java_opts_append_non_proxy
  set -l non_proxy (string replace -a , \| $no_proxy)
  if test -n $non_proxy
    set -xa JAVA_OPTS -Dhttp.nonProxyHosts=\"$non_proxy\"
  end
end

__java_opts_append_proxy http $http_proxy
__java_opts_append_proxy https $https_proxy
__java_opts_append_non_proxy

set -x MAVEN_HOME /usr/local/stow/apache-maven-3.8.4
set -x MAVEN_OPTS "-Xmx2g -Xshare:on -XX:TieredStopAtLevel=1 -XX:+UseParallelGC"

if status --is-interactive
  abbr --add --global mvn mvn -T1.0C -Dmaven.buildNumber.skip=true
  abbr --add --global mp  mvn -T1.0C -Dmaven.buildNumber.skip=true -DskipTests package
  abbr --add --global mcp mvn -T1.0C -Dmaven.buildNumber.skip=true -DskipTests clean package
  abbr --add --global mci mvn -T1.0C -Dmaven.buildNumber.skip=true -DskipTests clean install
  abbr --add --global mpt mvn -T1.0C -Dmaven.buildNumber.skip=true package test

  abbr --add --global kp kc build
  abbr --add --global kpa kc build --force
  abbr --add --global kcp kc build --clean
  abbr --add --global kcpa kc build --clean --force
  abbr --add --global kd kc deploy
  abbr --add --global kr kc start
  abbr --add --global ks kc stop
end

function psql --wraps psql --description 'alias psql=psql -U postgres'
  command psql -U postgres $argv
end

function createdb --wraps createdb --description 'alias createdb=createdb -U postgres'
  command createdb -U postgres $argv
end

function dropdb --wraps dropdb --description 'alias dropdb=dropdb -U postgres'
  command dropdb -U postgres $argv
end

function pg_restore --wraps pg_restore --description 'alias pg_restore=pg_restore -U postgres'
  command pg_restore -U postgres $argv
end

function pg_dump --wraps pg_dump --description 'alias pg_dump=pg_dump -U postgres'
  command pg_dump -U postgres $argv
end

function pull-all
  for r in (dirname */.git/)
    set_color yellow; echo $r; set_color normal;
    command git -C "$r" pull --rebase --autostash
  end
  for r in (dirname */.hg/)
    set_color yellow; echo $r; set_color normal;
    command hg -R $r shelve
    set -l shelve_status $status
    command hg -R $r pull --rebase
    if test $shelve_status -eq 0
      command hg -R $r unshelve
    end
  end
end
