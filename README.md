# Setup and settings

There are moments when you are setting up a new machine elsewhere or want to help out a friend and when you know that you have it working on your… oh wait… yes, on your _other_ machine that you can't reach at the moment. To avoid this - _or at least to ease the pain_ - I created this repo with a small collection of settings and setup instructions. It's meant to be for my own purposes, but feel free to have a look and feel inspired or so…

## Table of contents

- [Setup instructions](#setup-instructions)
  - [Step 1: Installing Homebrew](#step-1-installing-homebrew-and-zsh)
  - [Step 2: Change user shell](#step-2-change-user-shell)
  - [Step 3: Installing Ruby](#step-3-installing-ruby)
  - [Step 4: Installing and setup PostgreSQL](#step-4-installing-and-setup-postgresql)
  - [Step 5: Install remaining Homebrew packages](#step-5-install-remaining-homebrew-packages)
  - [Step 6: Installing other tools](#step-6-installing-other-tools)

## Step 1: Installing Homebrew, ZSH and asdf

Executing the line from the [Homebrew homepage](http://brew.sh):

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Installing (a more recent version of) ZSH and antigen for managing the plugins:

```bash
$ /opt/homebrew/bin/brew install zsh antigen asdf rust jemalloc
```

You can also call _brew_ without the whole path if you adjusted the PATH variable to include this path.

Copy over the `.antigenrc` and `.zshrc` file from [dotfiles](./dotfiles) to `$HOME/.zshrc`. Add the following line to `.zshrc` to enable `asdf` completions:

```bash
. /opt/homebrew/opt/asdf/libexec/asdf.sh
```

## Step 2: Change user shell

Add ZSH from Homebrew to available shells:

```bash
$ sudo echo "/opt/homebrew/bin/zsh" >> /etc/shells
```

Change user login shell to ZSH:

```bash
$ chsh -s /opt/homebrew/bin/zsh $USER
```

Log out, log in again and we are fine to run a more recent version of ZSH!

## Step 3: Installing Ruby

New Ruby versions will be installed via `asdf` and the corresponding plugin:

 ```bash
$ asdf plugin-add ruby
```

Copy over the [.default-gems file](./dotfiles/.default-gems) to define gems that will be installed together with each Ruby version.

Install Ruby 3.2.2 via ASDF:

```bash
$ asdf install ruby 3.2.2
```

Install Ruby 3.2.2 via `asdf` using `openssl3` from Homebrew and using jemalloc:


```bash
$ export RUBY_CONFIGURE_OPTS="--with-jemalloc --with-openssl-dir=$(brew --prefix openssl@3) --enable-yjit" asdf install ruby 3.2.2
```

This can be omitted when the proper settings are already present in `.zshrc`:

```bash
# .zshrc
...
export RUBY_CONFIGURE_OPTS="--with-jemalloc --with-openssl-dir=$(brew --prefix openssl@3) --enable-yjit"
...
```

Change the used Ruby from the System Ruby to the newly installed Ruby:

```bash
$ asdf global ruby 3.2.2
```

Revert back to System Ruby:

```bash
$ asdf global ruby system
```

## Step 4: Installing and setup PostgreSQL

Thanks to Homebrew this will be very easy!

### Installing:

```bash
$ brew install postgresql@16
```

### Creating the tables:

```bash
$ initdb --data-checksums --encoding=UTF-8 --locale=de_DE.UTF-8 -D /opt/homebrew/var/postgresql@16
```

### Migrating data:

#### Using `pg_dumpall` (example use for migration from 15 -> 16)

Switch to old version of Postgresql if a newer major one has been installed and already linked (assuming the old data is located in `/opt/homebrew/var/postgres@15`):

```bash
$ brew services stop postgresql@16
$ brew switch postgresql@15
$ brew services start postgresql@15
$ pg_dumpall > /PATH/TO/DUMP
$ brew services stop postgresql@15
$ mv /opt/homebrew/var/postgresql@15 /opt/homebrew/var/postgres.old
$ brew switch postgresql@16
$ initdb --data-checksums --encoding=UTF-8 --locale=de_DE.UTF-8 -D /opt/homebrew/var/postgresql@16
$ brew services start postgresql@16
$ psql -d postgres -f /PATH/TO/DUMP
```

#### Using `pg_upgrade`

Assuming we have a server with version 15.4 that has been upgraded to 16.0. First make sure any currently running postgres processes are stopped.
After this we initialize the new data directory:

```bash
$ /opt/homebrew/Cellar/postgresql@16/16.0/bin/initdb --data-checksums --encoding=UTF-8 --locale=de_DE.UTF-8 -D /opt/homebrew/var/postgresql@16
```

Then we migrate the data from the old data dir to the new data dir:

```bash
$ /opt/homebrew/Cellar/postgresql@16/16.0/bin/pg_upgrade \
--old-datadir /opt/homebrew/var/postgresql@15 \
--new-datadir /opt/homebrew/var/postgresql@16 \
--old-bindir /opt/homebrew/Cellar/postgresql@15/15.4/bin \
--new-bindir /opt/homebrew/Cellar/postgresql@16/16.0/bin
```

After the process was _hopefully_ successful we can safely delete the old cluster and analyze the data of the migrated data (do not forget to start the PG server before doing the analyze step):

```bash
$ rm -rf /opt/homebrew/var/postgresql@15
$ brew services start postgresql@16
$ /opt/homebrew/Cellar/postgresql@16/16.0/bin/vacuumdb --all --analyze-in-stages
```

## Step 5: Install remaining Homebrew packages

Using `brew bundle` and a proper [Brewfile](./Settings/brew/Brewfile) it's rather easy to install all desired packages. Make sure to run `brew bundle` from the location where the `Brewfile` has been placed.

## Step 6: Installing other tools

### Node

Copy over the [.default-npm-packages file](./dotfiles/.default-npm-packages) to define npm packages that will be installed together with each Node version.


Install node via asdf:

```bash
$ asdf plugin-add nodejs
# Install Node 20.8.0
$ asdf install nodejs 20.8.0
# install latest node version and latest npm
$ asdf install nodejs latest
# Define a global node version
$ asdf global nodejs 20.8.0
```

### Terraform

Install terraform via asdf:

```bash
$ asdf plugin-add terraform
$ asdf install terraform 1.6.1
$ asdf global terraform 1.6.1
```
