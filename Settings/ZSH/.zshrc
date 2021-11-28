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
### Used by homebrew
export HOMEBREW_GITHUB_API_TOKEN=<INSERT_YOUR_GITHUB_API_TOKEN_HERE>

### Set VS Code as the default editor
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export EDITOR="code --wait"
export BUNDLE_EDITOR="code"

## Adding node to PATH
export NPM_PACKAGES="$HOME/.node"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules"
export PATH="$HOME/.node/bin:$PATH"

### Set home for rbenv and adjust PATH
export RBENV_ROOT="$HOME/.rbenv"
export RBENV_PLUGINS="$RBENV_ROOT/plugins"
export PATH="$RBENV_ROOT/bin:$PATH"

### Set home for pyenv and adjust PATH
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"

### To enable shims and autocompletion for rbenv
if
  which rbenv > /dev/null;
  then eval "$(rbenv init -)";
fi

### To enable shims autocompletion for pyenv
# if
#   command -v pyenv 1>/dev/null 2>&1;
#   then eval "$(pyenv init -)";
# fi

### Make terminal notifier available for guard
export TERMINAL_NOTIFIER_BIN=/usr/local/bin/terminal-notifier

### Add the following to your zshrc to access the online help:
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

### NVM specific settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### Respect existing .nvmrc to automatically switch node version
### https://stackoverflow.com/a/64982608
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

if [ "$nvmrc_node_version" = "N/A" ]; then
  nvm install
elif [ "$nvmrc_node_version" != "$node_version" ]; then
  nvm use
fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

### Ruby specific setting
# Print out deprecation warnings
export RUBYOPT='-W:deprecated'
# Hide deprecation warnings
# export RUBYOPT='-W:no-deprecated'
# Set configure options for ruby: use jemalloc version and homebrew openssl
export RUBY_CONFIGURE_OPTS="--with-jemalloc --with-openssl-dir=$(brew --prefix openssl)"

### Terraform
export HCLOUD_TOKEN=<INSERT_YOUR_HETZNER_CLOUD_API_TOKEN_HERE>
complete -o nospace -C /usr/local/bin/terraform terraform

autoload -U +X bashcompinit && bashcompinit
