# Save me under: $HOME/.zshrc

# Plugins
source /usr/local/share/antigen/antigen.zsh

# Source additional config.
source $HOME/.antigenrc

### Set PATH, MANPATH, etc. for Homebrew.
eval "$(/usr/local/bin/brew shellenv)"

### Set brew cask link directory
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

### Token for Github API to avoid limited requests
### Used by homebrew
export HOMEBREW_GITHUB_API_TOKEN=<INSERT_YOUR_GITHUB_API_TOKEN_HERE>

### Set VS Code as the default editor
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export EDITOR="code --wait"
export BUNDLE_EDITOR="code"

### Make terminal notifier available for guard
export TERMINAL_NOTIFIER_BIN=/usr/local/bin/terminal-notifier

### Add the following to your zshrc to access the online help:
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

### Ruby specific setting
# Set configure options for ruby
export RUBY_CONFIGURE_OPTS="--with-jemalloc --with-openssl-dir=$(brew --prefix openssl@3)"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Enable ASDF completions
. /usr/local/opt/asdf/libexec/asdf.sh
