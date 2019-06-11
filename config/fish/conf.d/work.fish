set -x SERVERS_HOME ~/Work/servers

function mvn --wraps mvn --description 'alias mvn=mvn --threads 1.0C -Dmaven.buildNumber.skip=true'
  command mvn --threads 1.0C -Dmaven.buildNumber.skip=true $argv
end

function mcp --wraps mvn --description 'alias mcp=mvn -DskipTests clean package'
  mvn -DskipTests clean package $argv
end

function mci --wraps mvn --description 'alias mci=mvn -DskipTests clean install'
  mvn -DskipTests clean install $argv
end

function mp --wraps mvn --description 'alias mp=mvn -DskipTests package'
  mvn -DskipTests package $argv
end

function project-name
  if set root (hg root 2>/dev/null)
    echo (basename $root)-(hg branch)
  else if set root (git rev-parse --show-toplevel 2>/dev/null)
    echo (basename $root)-default
  else
    return 1
  end
end

function project-instance-path
  if test -n "$argv[1]"
    echo $SERVERS_HOME/$argv[1]
  else if set name (project-name)
    echo $SERVERS_HOME/$name
  else
    return 1
  end
end

function project-log-session
  if set name (project-name); and set instance (project-instance-path $name)
    tmux \
      new-session -d -s $name -c $instance "tail -F jboss-bas-8.2.1.krista26/standalone/log/server.log" \; \
      new-window -t $name: -c $instance -d "tail -F gc.log" \; \
      new-window -t $name: -c $instance -d
  else
    return 1
  end
end

function wildfly-run-commands
  set bin ./jboss-*/bin
  if set instance (project-instance-path)
    set bin $instance/jboss-*/bin
  end
  if test -x $bin/jboss-cli.sh
    pushd $bin
    command ./jboss-cli.sh -c --commands=$argv[1]
    popd
  else
    return 1
  end
end

function wildfly-db
  wildfly-run-commands "/subsystem=datasources/data-source=DataaccessDS:read-attribute(name=connection-url)"
end

function wildfly-sql-enable
   wildfly_run_commands "/subsystem=logging/logger=org.hibernate.SQL:write-attribute(name=level,value=DEBUG),/subsystem=logging/logger=org.hibernate.type:write-attribute(name=level,value=TRACE)"
end

function wildfly-sql-disable
   wildfly_run_commands "/subsystem=logging/logger=org.hibernate.SQL:write-attribute(name=level,value=OFF),/subsystem=logging/logger=org.hibernate.type:write-attribute(name=level,value=OFF)"
end

function wildfly-log
  wildfly_run_commands "/subsystem=logging/pattern-formatter=PATTERN:write-attribute(name=pattern,value=\"%d{yyyy-MM-dd HH:mm:ss,SSS}  %-6.6p (%-30.30t) [%30.30c{1.}] %s%E%n\")"
end

function kr
  set krupd ./krupd
  if set instance (project-instance-path)
    set krupd $instance/krupd
  end
  if test -e $krupd; and test -x $krupd
    pushd (dirname $krupd)
    command $krupd $argv
    popd
  else
    return 1
  end
end

function krr --description 'alias krr=kr jboss.start'
  kr jboss.start $argv
end

function krs --description 'alias krs=kr jboss.stop'
  kr jboss.stop $argv
end

function deploy
  if set instance (project-instance-path)
    for ext in war ear
      for deployment in $instance/jboss-*/standalone/deployments/*.$ext
        set module (basename $deployment .$ext)
        if set assembled (find . -wholename "*$module/target/$module.$ext" | grep '.*'); and command test $assembled -nt $deployment
          cp -v $assembled $deployment
        end
      end
    end
  else
    return 1
  end
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
