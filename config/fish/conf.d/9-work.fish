set -x SERVERS_HOME /z

set -x JAVA_HOME /etc/java-config-2/current-system-vm
set -x JAVA_OPTS "\
-Dhttp.nonProxyHosts=\"localhost|127.0.*|10.0.*|172.17.*|172.20.*|178.218.42.94|192.168.*|*.krista.ru\" \
-Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=3128 \
-Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=3128 \
"
set -x MAVEN_HOME /usr/local/stow/apache-maven-3.8.4
set -x MAVEN_OPTS "-Xmx2g -Xshare:on -XX:TieredStopAtLevel=1 -XX:+UseParallelGC"

if status --is-interactive
  abbr --add --global mvn mvn -T1.0C -Dmaven.buildNumber.skip=true
  abbr --add --global mp  mvn -T1.0C -Dmaven.buildNumber.skip=true -DskipTests package
  abbr --add --global mcp mvn -T1.0C -Dmaven.buildNumber.skip=true -DskipTests clean package
  abbr --add --global mci mvn -T1.0C -Dmaven.buildNumber.skip=true -DskipTests clean install
  abbr --add --global mpt mvn -T1.0C -Dmaven.buildNumber.skip=true package test

  abbr --add --global kr k start
  abbr --add --global ks k stop
  abbr --add --global kp k build
  abbr --add --global kcp k build --clean
  abbr --add --global kpr k build --restart
  abbr --add --global kcpr k build --clean --restart
  abbr --add --global kcpa k build --rebuild --clean
  abbr --add --global kcpar k build --rebuild --clean --restart
  abbr --add --global kd k deploy
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
