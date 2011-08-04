# Ruby specific commands
alias rrm='rake routes | mate'
alias 'gem?'='gem list | grep -i $1'
alias run_specs="bundle exec rspec spec/models"
alias run_acceptance="bundle exec rspec spec/acceptance"
alias gi='git'

# Directory/File commands
alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~/'
alias testlog='tail -f log/test.log'
alias testlogd='tail -f log/test.log | grep DEBUG'
alias devlogd='tail -f log/development.log | grep DEBUG'
alias rr='touch tmp/restart.txt'
alias r='rails'
alias q='exit'
alias be="bundle exec"

# Git specific commands
alias gpo='git push origin'
alias gundo='git reset HEAD'
alias 'branch?'='git branch | grep -i $1'

# Pow commands
alias kapow='powify server restart'

# Functions
function sc() {
  if [ -f ./script/rails ]; then
    rails c
  else
    ./script/console
  fi
}

function ss() {
  if [ -f ./script/rails ]; then
    rails s
  else
    ./script/server
  fi
}

function sgc() {
  if [ -f ./script/rails ]; then
    rails g controller
  else
    ./script/generate controller $1
  fi
}

function sgrc() {
  ./script/generate rspec_controller $1
}

function sgmi() {
  if [ -f ./script/rails ]; then
    rails g migration $1
  else
    ./script/generate migration $1
  fi
}

function sgm() {
  if [ -f ./script/rails ]; then
    rails g model $1
  else
    ./script/generate model $1
  fi
}

function sgrm() {
  ./script/generate rspec_model
  # TODO: Add Rails 3 specific command
}

function sd() {
  ./script/destroy
  # TODO: Add Rails 3 specific command
}

function migrate() {
  if [[ $1 == '' ]]; then
    echo 'Migrating Development Database'
    rake db:migrate RAILS_ENV=development
    echo 'Preparing Test Database'
    rake db:test:clone_structure
  else
    rake db:migrate RAILS_ENV=$1
  fi
}

function rollback() {
  if [[ $1 == '' ]]; then
    echo 'Rolling Back Development Database'
    rake db:rollback RAILS_ENV=development
    echo 'Preparing Test Database'
    rake db:test:clone_structure
  else
    rake db:rollback RAILS_ENV=$1
  fi
}

function switch_user() {
case "$1" in
  'eddorre')
  git config user.name 'eddorre'
  git config user.email 'carlos@eddorre.com'
  print 'Setup git project to user eddorre as the username and carlos@eddorre.com as the email address'
;;
  'planetargon')
  git config user.name 'Carlos Rodriguez'
  git config user.email 'carlos@planetargon.com'
  print 'Setup git project to user Carlos Rodriguez as the username and carlos@planetargon.com as the email address'
;;
esac
}