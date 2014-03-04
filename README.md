# Setup and settings

There are moments when you are setting up a new machine elsewhere or want to help out a friend and when you know that you have it working on your… oh wait… yes, on your _other_ machine that you can't reach at the moment. To avoid this - _or at least to ease the pain_ - I created this repo with a small collection of settings and setup instructions. It's meant to be for my own purposes, but feel free to have a look and feel inspired or so…

## Table of contents

- [Application settings](#application-settings)
    - [GitHub](#github)
    - [RubyGems](#rubygems)
    - [Sublime Text 3](#sublime-text-3)
    - [ZSH](#zsh)
- [Setup instructions](#setup-instructions)
    - [Step 1: Installing Homebrew](#step-1-installing-homebrew-and-zsh)
    - [Step 2: Change user shell](#step-2-change-user-shell)
    - [Step 3: Installing oh-my-zsh](#step-3-installing-oh-my-zsh)
    - [Step 4: Installing Ruby](#step-4-installing-ruby)
    - [Step 5: Installing and setup databases](#step-5-installing-and-setup-databases)
        * [MySQL](#mysql)
        * [PostgreSQL](#postgresql)
    - [Step 6: Homebrew packages](#step-6-homebrew-packages)
    - [Step 7: Sublime Text 3](#step-7-sublime-text-3)

## Application settings

The repo holds a folder ['Settings'](Settings) that contains - _wait for it_ - settings! They are for:

### [GitHub](Settings/GitHub/)

- user-based gitconfig
- global gitignore
- template for a commit message

### [RubyGems](Settings/Ruby/)

- settings for default gem installation

### [Sublime Text 3](Settings/Sublime%20Text%203/)

- Package settings
- User settings

### [ZSH](Settings/ZSH/)

- zshrc file with aliases, plugins and shell variables

## Setup instructions

### Step 1: Installing Homebrew and ZSH

Executing the line from the [Homebrew homepage](http://brew.sh):

```bash
$ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

Installing (a more recent version of) ZSH:

```bash
$ /usr/local/bin/brew install zsh
```

You can also call _brew_ without the whole path if you adjusted the PATH variable to include this path.

### Step 2: Change user shell

Add ZSH to available shells:

```bash
$ sudo echo "/usr/local/bin/zsh" >> /etc/shells
```

Change user login shell to ZSH:

```bash
$ chsh -s /usr/local/bin/zsh $USER
```

Log out, log in again and we are fine to run ZSH!

### Step 3: Installing oh-my-zsh

Executing the line from the [oh-my-zsh GitHub page](https://github.com/robbyrussell/oh-my-zsh):

```bash
$ curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

Copy over the .zshrc file from [ZSH Settings](Settings/ZSH) to $HOME/.zshrc.

### Step 4: Installing Ruby

New Ruby versions will be installed via rbenv (I also use [rbenv-gemset](https://github.com/jf/rbenv-gemset))

```bash
$ brew install rbenv ruby-build rbenv-gemset
```

Adjust the PATH variable in .zshrc:

```bash
### Adjust PATH for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
```

Install Ruby 2.1.1 via rbenv and thanks to ruby-build we can simply type:

```bash
$ rbenv install 2.1.1
```

Change the used Ruby from the System Ruby to the newly installed Ruby:

```bash
$ rbenv global 2.1.1
```

Revert back to System Ruby:

```bash
$ rbenv global system
```

### Step 5: Installing and setup databases

Thanks to Homebrew this will be very easy!

#### MySQL

Installing:

```bash
$ brew install mysql
```

#### PostgreSQL

##### Installing:

```bash
$ brew install postgresql
```

##### Creating the tables:

```bash
$ initdb --encoding=UTF-8 --locale=de_DE.UTF-8 -D /usr/local/var/postgres/9.3
```

_Note: I like to separate the data directories by their minor version number for easier upgrade when a new minor version appears. By this it is possible to simply migrate the data from on minor version to another minor version ([see abstract about migrating data](#migrating-data))._

##### Migrating data:

Assuming we have a server with version 9.3.x that has been upgraded to 9.4.0. We start both versions of the database servers that listen to different ports:

```bash
$ /usr/local/Cellar/postgresql/9.3.x/bin/pg_ctl -D /usr/local/var/postgres/9.3 -o "-p 5000" start
$ /usr/local/Cellar/postgresql/9.4.0/bin/pg_ctl -D /usr/local/var/postgres/9.4 -o "-p 5001" start
```

Then we migrate the data from the old data dir to the new data dir:

```bash
$ /usr/local/Cellar/postgresql/9.4.0/bin/pg_upgrade \
-b /usr/local/Cellar/postgresql/9.3.x/bin \
-B /usr/local/Cellar/postgresql/9.4.0/bin \
-d /usr/local/var/postgres/9.3 \
-D /usr/local/var/postgres/9.4
```

Stop the servers after the process was _hopefully_ successful:

```bash
$ /usr/local/Cellar/postgresql/9.3.x/bin/pg_ctl -D /usr/local/var/postgres/9.3 -o "-p 5000" stop
$ /usr/local/Cellar/postgresql/9.4.0/bin/pg_ctl -D /usr/local/var/postgres/9.4 -o "-p 5001" stop
```

### Step 6: Homebrew packages

Over the time the list of installed packages from Homebrew got longer and longer. Here are lists, separated by _categories_.

#### Standard stuff:

```bash
$ brew install aria2 \
md5sha1sum \
bash-completion \
dos2unix \
unrar \
wakeonlan \
wget \
gnupg2 \
openssl \
curl \
curl-ca-bundle \
colordiff \
zsh
```

#### Versioning and Development:

```bash
$ brew install git \
mercurial \
subversion \
heroku-toolbelt \
libyaml \
libxml2 \
libxslt \
readline \
rbenv \
ruby-build \
rbenv-gemset \
ctags
```

#### Multimedia-Stuff:

```bash
$ brew install ghostscript \
imagemagick \
ps2eps \
ffmpeg \
mplayer \
mjpegtools \
mp4v2 \
x264 \
XviD \
graphviz
```

#### Datenbanken:

```bash
$ brew install mysql \
postgresql \
sqlite3
```

#### File-Sharing:

```bash
$ brew install samba
```

### Step 7: Sublime Text 3

Start with creating a symbolic link so that we can use Sublime from the command line:

```bash
$ ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin
```

Continue with installing __Package Control__ for easier installing packages:

```bash
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
git clone git://github.com/wbond/sublime_package_control.git Package\ Control
cd Package\ Control
git checkout python3
 
# restart Sublime Text 3 and you should have Package Control working
```

Thanks to [_moomerman_](https://github.com/moomerman) for this nice [Gist](https://gist.github.com/moomerman/4674060)! As an alternative there are also instructions on the [Sublime page](https://sublime.wbond.net/installation).

Installing packages is easy via shortcut: __SHIFT + CMD + p__, followed by typing: __Package Control: Install Package__ (_thanks to fuzzy finder it is sufficent to just type two or three letters of this command_).

The Sublime page also has a sweet [search function](https://sublime.wbond.net/search) for available packages.

#### Package list

- [All Autocomplete](https://github.com/alienhard/SublimeAllAutocomplete)
- [ApplySyntax](https://github.com/facelessuser/ApplySyntax)
- [Better CoffeeScript](https://github.com/aponxi/sublime-better-coffeescript)
- [CTags](https://github.com/SublimeText/CTags)
- [ChangeQuotes](https://github.com/colinta/SublimeChangeQuotes)
- [CoffeeScriptHaml](https://github.com/jisaacks/CoffeeScriptHaml)
- [Configify](https://github.com/loganhasson/configify)
- [Emmet](https://github.com/sergeche/emmet-sublime)
- [File Navigator](https://github.com/Chris---/SublimeText-File-Navigator)
- [Git Config](https://github.com/robballou/gitconfig-sublimetext)
- [GitGutter](http://www.jisaacks.com/gitgutter)
- [Git](https://github.com/kemayo/sublime-text-git)
- [Gitignore](https://github.com/theadamlt/Sublime-Gitignore)
- [HTML2HAML (sublime-html-to-haml)](https://github.com/pavelpachkovskij/sublime-html-to-haml) (install manually via Git)
- [Handlebars](https://github.com/daaain/Handlebars)
- [I18n Rails](https://github.com/NicoSantangelo/sublime-text-i18n-rails)
- [LESS](https://github.com/danro/LESS-sublime)
- [List LESS Variables](https://github.com/MaciekBaron/sublime-list-less-vars)
- [Markdown Preview](https://github.com/revolunet/sublimetext-markdown-preview)
- [MarkdownEditing](https://github.com/SublimeText-Markdown/MarkdownEditing)
- [Modific](https://github.com/gornostal/Modific)
- [Package Control](https://sublime.wbond.net/installation)
- [RSpec](https://github.com/SublimeText/RSpec)
- [Rails Developer Snippets](https://github.com/j10io/railsdev-sublime-snippets)
- [Rails Partial](https://github.com/wesf90/rails-partial)
- [RailsCasts Colour Scheme](https://github.com/tdm00/sublime-theme-railscasts)
- [RailsGoToSpec](https://github.com/sporto/rails_go_to_spec)
- [Ruby Slim](https://github.com/slim-template/ruby-slim.tmbundle)
- [SSH Config](https://github.com/robballou/sublimetext-sshconfig)
- [SideBarEnhancements](https://github.com/titoBouzout/SideBarEnhancements)
- [SideBarFolders](https://github.com/SublimeText/SideBarFolders)
- [SideBarGit](https://github.com/SublimeText/SideBarGit)
- [SublimeLinter-coffee](https://github.com/SublimeLinter/SublimeLinter-coffee)
- [SublimeLinter-haml](https://github.com/SublimeLinter/SublimeLinter-haml)
- [SublimeLinter-json](https://github.com/SublimeLinter/SublimeLinter-json)
- [SublimeLinter-ruby](https://github.com/SublimeLinter/SublimeLinter-ruby)
- [SublimeLinter](http://sublimelinter.readthedocs.org/en/latest/)
- [SublimeREPL](https://github.com/wuub/SublimeREPL)
- [Syntax Highlighting for Sass (and also SCSS)](https://github.com/P233/Syntax-highlighting-for-Sass)
- [Theme - Soda](http://buymeasoda.github.io/soda-theme/)
- [jQuery](https://github.com/SublimeText/jQuery)
- [rbenv](https://github.com/felipeelias/sublime-text-2-rbenv)

#### Package settings

Find them under [Settings for Sublime Text 3](Settings/Sublime%20Text%203/).
