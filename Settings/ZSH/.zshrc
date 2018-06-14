# Save me under: $HOME/.zshrc

# Plugins
source /usr/local/share/antigen/antigen.zsh

# Source additional config.
source $HOME/.aliasesrc
source $HOME/.antigenrc

# Customize to your needs...
export PATH="$PATH:/usr/local/sbin:/usr/local/share/npm/bin:/usr/bin:/bin:/usr/sbin:/sbin"

export MANPATH="/usr/local/share:/usr/local/man:$MANPATH"

### Adding brew stuff to beginning of path
export PATH="/usr/local/bin:$PATH"

### Set brew cask link directory
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

### Token for Github API to avoid limited requests
export HOMEBREW_GITHUB_API_TOKEN=<INSERT_YOUR_GITHUB_API_TOKEN_HERE>

### Set VS Code as the default editor
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export EDITOR="code --wait"
export BUNDLE_EDITOR="code"

### Adjust PATH for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

### Set home for rbenv
export RBENV_ROOT="$HOME/.rbenv"
export RBENV_PLUGINS="$RBENV_ROOT/plugins"

### To enable shims and autocompletion for rbenv
if
  which rbenv > /dev/null;
  then eval "$(rbenv init -)";
fi

### Make terminal notifier available for guard 
export TERMINAL_NOTIFIER_BIN=/usr/local/bin/terminal-notifier

