# Setup and settings

There are moments when you are setting up a new machine elsewhere or want to help out a friend and when you know that you have it working on your… oh wait… yes, on your _other_ machine that you can't reach at the moment. To avoid this - _or at least to ease the pain_ - I created this repo with a small collection of settings and setup instructions. It's meant to be for my own purposes, but feel free to have a look and feel inspired or so…

## Table of contents

- [Application settings](#application-settings)
    - [GitHub](#github)
    - [RubyGems](#rubygems)
    - [Sublime Text](#sublime-text)
    - [ZSH](#zsh)
- [Setup instructions](#setup-instructions)
    1. [Installing Homebrew](#1-installing-homebrew)
    2. [Change user shell](#2-change-user-shell)
    3. [Installing oh-my-zsh](#3-installing-oh-my-zsh)
    4. [Installing Ruby](#4-installing-ruby)
    5. [Installing databases](#5-installing-databases)
        - [MySQL](#mysql)
        - [PostgreSQL](#postgresql)
    6. My Homebrew packages

## Application settings

The repo holds a folder ['Settings'](Settings) that contains - _wait for it_ - settings! They are for:

### [GitHub](Settings/GitHub/)

- user-based gitconfig
- global gitignore
- template for a commit message

### [RubyGems](Settings/Ruby/)

- settings for default gem installation

### [Sublime Text](Settings/Sublime%20Text/)

- package settings
- user settings

### [ZSH](Settings/ZSH/)

- zshrc file with aliases, plugins and shell variables

## Setup instructions

### 1. Installing Homebrew and ZSH

Executing the line from the [Homebrew homepage](http://brew.sh):

    $ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

Installing (a more recent version of) ZSH after adjusting PATH variable:

    $ brew install zsh

### 2. Change user shell

Add ZSH to available shells:

    $ sudo echo "/usr/local/bin/zsh" >> /etc/shells

Change user login shell to ZSH:

    $ chsh -s /usr/local/bin/zsh $USER

Log out, log in again and we are fine to run ZSH!

### 3. Installing oh-my-zsh

Executing the line from the [oh-my-zsh GitHub page](https://github.com/robbyrussell/oh-my-zsh):

    $ curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

Copy over the .zshrc file from [ZSH Settings](Settings/ZSH) to $HOME/.zshrc.

### 4. Installing Ruby

New Ruby versions will be installed via rbenv (I also use [rbenv-gemset](https://github.com/jf/rbenv-gemset))

    $ brew install rbenv ruby-build rbenv-gemset

Adjust the PATH variable in .zshrc:

    ### Adjust PATH for rbenv
    export PATH="$HOME/.rbenv/bin:$PATH"

Install Ruby 2.1.1 via rbenv and thanks to ruby-build we can simply type:

    $ rbenv install 2.1.1

Change the used Ruby from the System Ruby to the newly installed Ruby:

    $ rbenv global 2.1.1

Revert back to System Ruby:

    $ rbenv global system

### 5. Installing databases

Thanks to Homebrew this will be very easy!

#### MySQL

Installing:

    $ brew install mysql

#### PostgreSQL

##### Installing:

    $ brew install postgresql

##### Creating the tables:

    $ initdb --encoding=UTF-8 --locale=de_DE.UTF-8 -D /usr/local/var/postgres/9.3

_Note: I like to separate them by their minor version number for easier upgrade when a new minor version appears. By this it is possible to simply migrate the data from on minor version to another minor version ([see abstract about migrating data](#migrating-data))._

##### Migrating data:

Assuming we had a server with version 9.3.x that has been upgraded to 9.4.0. We start both versions of the database servers that listen to different ports:

    $ /usr/local/Cellar/postgresql/9.3.x/bin/pg_ctl -D /usr/local/var/postgres/9.3 -o "-p 5000" start
    $ /usr/local/Cellar/postgresql/9.4.0/bin/pg_ctl -D /usr/local/var/postgres/9.4 -o "-p 5001" start

Then we migrate the data from the old data dir to the new data dir:

    $ /usr/local/Cellar/postgresql/9.4.0/bin/pg_upgrade \
    -b /usr/local/Cellar/postgresql/9.3.x/bin \
    -B /usr/local/Cellar/postgresql/9.4.0/bin \
    -d /usr/local/var/postgres/9.3 \
    -D /usr/local/var/postgres/9.4

Stop the servers after the process was _hopefully_ successful:

    $ /usr/local/Cellar/postgresql/9.3.x/bin/pg_ctl -D /usr/local/var/postgres/9.3 -o "-p 5000" stop
    $ /usr/local/Cellar/postgresql/9.4.0/bin/pg_ctl -D /usr/local/var/postgres/9.4 -o "-p 5001" stop
