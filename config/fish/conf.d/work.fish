set -x SERVERS_HOME /z

if status --is-interactive
  abbr --add --global mvn mvn -T1.0C -Dmaven.buildNumber.skip=true
  abbr --add --global mp  mvn -T1.0C -Dmaven.buildNumber.skip=true -DskipTests package
  abbr --add --global mcp mvn -T1.0C -Dmaven.buildNumber.skip=true -DskipTests clean package
  abbr --add --global mci mvn -T1.0C -Dmaven.buildNumber.skip=true -DskipTests clean install
  abbr --add --global mpt mvn -T1.0C -Dmaven.buildNumber.skip=true package test
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

function mounts
  sudo mount --bind "$HOME/Dev" /w
  sudo mount --bind "$HOME/Work" /x
  sudo mount --bind "$HOME/Work/servers" /z
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
