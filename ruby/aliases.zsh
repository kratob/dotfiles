# Rails 3 aliases, backwards-compatible with Rails 2.

function _rails_command () {
  if [ -e "script/server" ]; then
    ruby script/$@
  else
    ruby script/rails $@
  fi
}

alias pryc='pry -r./config/environment.rb -rrails/console/app'
alias rc='_rails_command console'
alias rg='_rails_command generate'
alias rd='_rails_command destroy'
alias rdb='_rails_command dbconsole'
alias rdbm='b rake db:migrate db:test:clone'
alias rp='_rails_command plugin'
alias devlog='tail -f log/development.log'
alias rrs='touch tmp/restart.txt'

