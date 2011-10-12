# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="risto"

plugins=(rails3 git)

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="false"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/local/node/bin:~/bin:~/usr/local/lib/node:$PATH

# For autotest
export RSPEC=true autospec
export AUTOFEATURE=true autospec
export SILENCE_SPEC_DEPRECATION_WARNINGS=true

unsetopt auto_name_dirs

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
