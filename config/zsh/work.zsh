# Maven
mvn_settings_xml () {
  local settings_path=$PWD
  while [[ ! -r "$settings_path/settings.xml" && "$settings_path" != "$HOME" && "$settings_path" != "/" ]] {
    settings_path="${settings_path:h}"
  }
  [[ -r "$settings_path/settings.xml" ]] && echo -n " --settings \"$settings_path/settings.xml\""
}

alias m='mvn --builder smart --threads 1.0C -Dmaven.buildNumber.skip=true `mvn_settings_xml`'
alias mcp='m -DskipTests clean   package'
alias mci='m -DskipTests clean   install'
alias  mp='m -DskipTests package'
alias mpt='m             package test'

alias mvn_install_smart_builder='() { m dependency:copy -Dartifact=io.takari.maven:takari-smart-builder:RELEASE "-DoutputDirectory=$1" }'

# Project
project_name () {
  local root
  root=$(hg root) || return 1
  local branch
  branch=$(hg branch) || return 1
  echo ${root:t}-$branch
}

project_instance_path () {
  local name
  if [[ -n $1 ]]; then
    name=$1
  else
    name=$(project_name) || return 1
  fi
  echo "$SERVERS_HOME/$name"
}

# Wildfly
wildfly_run_commands () {
  local instance
  instance=$(project_instance_path) || return 1
  local bin=($instance/jboss-*/bin)
  local cli=$bin/jboss-cli.sh
  [ -x "$cli" ] || return 1
  (cd "$bin" && "$cli" -c --commands=$1)
}

wildfly_db () {
  wildfly_run_commands "/subsystem=datasources/data-source=DataaccessDS:read-attribute(name=connection-url)"
}

wildfly_sql_enable () {
  wildfly_run_commands "/subsystem=logging/logger=org.hibernate.SQL:write-attribute(name=level,value=DEBUG),/subsystem=logging/logger=org.hibernate.type:write-attribute(name=level,value=TRACE)"
}

wildfly_sql_disable () {
  wildfly_run_commands "/subsystem=logging/logger=org.hibernate.SQL:write-attribute(name=level,value=OFF),/subsystem=logging/logger=org.hibernate.type:write-attribute(name=level,value=OFF)"
}

wildfly_log () {
  wildfly_run_commands "/subsystem=logging/pattern-formatter=PATTERN:write-attribute(name=pattern,value=\"%d{yyyy-MM-dd HH:mm:ss,SSS}  %-6.6p (%-30.30t) [%30.30c{1.}] %s%E%n\")"
}

wildfly_log_sync_trace () {
  wildfly_run_commands "/subsystem=logging/logger=ru.krista.retools.sync:write-attribute(name=level,value=TRACE)"
}

wildfly_log_sync_off () {
  wildfly_run_commands "/subsystem=logging/logger=ru.krista.retools.sync:write-attribute(name=level,value=INFO)"
}

# kc
alias kcr='kc start'
alias kcs='kc stop'
alias kcp='kc build package'
alias kcpd='kc build -d package'
alias kcpdr='kcpd && kcr'
alias kccp='kc build clean package'
alias kccpd='kc build -d clean package'
alias kccpdr='kccpd && kcr'
alias kccpa='kc build --rebuild clean package'
alias kccpad='kc build -a -d clean package'
alias kccpadr='kccpad && kcr'
alias kcd='kc deploy'
alias kcdf='kc deploy -f'

# k
alias kr='k start'
alias ks='k stop'
alias kp='k build'
alias kcp='k build --clean'
alias kpr='k build --restart'
alias kcpr='k build --clean --restart'
alias kcpa='k build --rebuild --clean'
alias kcpar='k build --rebuild --clean --restart'
alias kd='k deploy'

# # Krupd
# alias kcr='kc jboss.start'
# alias kcs='kc jboss.stop'

# deploy-cluster () {
#   local instance
#   instance=$(project_instance_path "cluster-$(project_name)") || return 1;
#   for node in $instance/node*(/); do
#     deploy $node
#   done
# }

# Postgresql
alias psql='psql -U postgres'
alias createdb='createdb -U postgres'
alias dropdb='dropdb -U postgres'
alias pg_restore='pg_restore -U postgres'
alias pg_dump='pg_dump -U postgres'

pull_all () {
  for r in *(/); do
    if [[ -d "$r/.git" ]]; then
      echo $fg[yellow]$r$reset_color
      git -C "$r" pull --rebase --autostash
    fi
    if [[ -d "$r/.hg" ]]; then
      echo $fg[yellow]$r$reset_color
      function () {
        hg -R "$r" --quiet --pager never incoming
        if [[ $? -ne 0 ]]; then
          hg -R "$r" update
          return
        fi
        hg -R "$r" --config extensions.shelve= shelve
        local shelve_status=$?
        hg -R "$r" --config extensions.rebase= pull --update --rebase
        if [[ $shelve_status -eq 0 ]]; then
          hg -R "$r" --config extensions.shelve= unshelve
        fi
      }
    fi
  done
}

fetch_all () {
  if [[ -d $PWD/.git || -d $PWD/.hg ]]; then
    local p=$PWD:h
  else
    local p=$PWD
  fi
  for r in $p/*(/); do
    if [[ -d $r/.git ]]; then
       echo $fg[yellow]$r$reset_color
       git -C $r fetch --all --prune --jobs=10
    fi
    if [[ -d $r/.hg ]]; then
       echo $fg[yellow]$r$reset_color
      hg -R $r pull -b. -bdefault
    fi
  done
}

mounts () {
  sudo mount --bind "$HOME/Dev" /w
  sudo mount --bind "$HOME/Work" /x
  sudo mount --bind "$HOME/Work/servers" /z
}

alias curl3129='curl --proxy 127.0.0.1:3129'
