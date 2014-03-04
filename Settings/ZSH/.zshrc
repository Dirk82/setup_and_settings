# Save me under: $HOME/.zshrc

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Aliases

# Paket Manager & Development

# Homebrew: General
alias brew_clean="brew cleanup --force -s"
alias brew_update="brew update; brew upgrade"
# Do rm -rf $(brew --cache) afterwards for cleaning the download cache

# Homebrew: MySQL, PG, ElasticSearch
alias start_es="brew services start elasticsearch"
alias stop_es="brew services stop elasticsearch"
alias start_mysql="brew services start mysql"
alias stop_mysql="brew services stop mysql"
alias start_pg="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias stop_pg="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"

# Ruby, Rails
alias clear_rails="rake log:clear; rake tmp:clear; rake assets:clean; rake tmp:create"
alias compile_production="RAILS_ENV=production bundle exec rake assets:precompile"
alias ruby_update="gem update --system; gem update"
alias uninstall_all_gems="for x in `gem list --no-versions`; do gem uninstall $x -a -x -I; done"

# Rbenv
alias rbr="rbenv rehash"

# LaTeX
alias tex_update="tlmgr update --self --all"

# Xcode
alias accept_xcode="sudo xcodebuild -license"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew bundler git heroku postgres rails rbenv)

source $ZSH/oh-my-zsh.sh

### Some PATH variables: customize to your needs...
export PATH="$PATH:/usr/local/share/npm/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"

export MANPATH="/usr/local/share:/usr/local/man:$MANPATH"
export NODE_PATH="/usr/local/lib/node"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Adding brew stuff to beginning of path
export PATH="/usr/local/bin:$PATH"

### Adjust PATH for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

export RBENV_ROOT="$HOME/.rbenv"

### Token for Github API to avoid limited requests
export HOMEBREW_GITHUB_API_TOKEN=<INSERT_YOUR_TOKEN_HERE>

### Set Sublime as the default editor
export EDITOR="subl -w"
export BUNDLE_EDITOR="subl"

### To enable shims and autocompletion for rbenv
if
  which rbenv > /dev/null;
  then eval "$(rbenv init -)";
fi