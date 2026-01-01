# Save me under: $HOME/.zshrc

# Plugins
source /opt/homebrew/share/antigen/antigen.zsh

# History management settings
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# Source additional config.
source $HOME/.antigenrc

### Set PATH, MANPATH, etc. for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

### Token for Github API to avoid limited requests
### Used by homebrew
export HOMEBREW_GITHUB_API_TOKEN=<INSERT_YOUR_GITHUB_API_TOKEN_HERE>
### Used by mise
export MISE_GITHUB_TOKEN=<INSERT_YOUR_GITHUB_API_TOKEN_HERE>

### Set VS Code as the default editor
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export EDITOR="code --wait"
export BUNDLE_EDITOR="code"

### Add the following to your zshrc to access the online help:
unalias run-help
autoload run-help
HELPDIR=/opt/homebrew/share/zsh/help

update_packages() {
  # Homebrew
  if type brew &> /dev/null; then
    echo "=== Updating Homebrew and packages ==="
    brew update
    brew upgrade
    echo "=== Finished updating Homebrew and packages ==="
    echo
  fi

  # Node, npm
  if type npm &> /dev/null; then
    echo "=== Updating node packages  ==="
    npm -g update
    echo "=== Finished updating node packages ==="
    echo
  fi
}

### Ruby specific setting
# Set configure options for ruby
# Set flags which help to find libraries when compiling development dependencies
export CPPFLAGS="$CPPFLAGS -I$HOMEBREW_PREFIX/include"
export LDFLAGS="$LDFLAGS -L$HOMEBREW_PREFIX/lib"
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
export RUBY_CONFIGURE_OPTS="--with-jemalloc --with-openssl-dir=$(brew --prefix openssl@3) --enable-yjit"
# Use YJIT for Ruby 3.2+
export RUBY_YJIT_ENABLE=1

# https://github.com/rails/rails/issues/38560
# Each of the two exports does the trick
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
# export PGGSSENCMODE=disable

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Activate mise
eval "$(mise activate zsh)"
