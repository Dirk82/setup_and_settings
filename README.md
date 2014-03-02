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
    2. Change user shell
    3. Installing oh-my-zsh
    4. Installing Ruby
    5. Installing databases

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

### 1. Installing Homebrew

Executing the line from the [Homebrew homepage](http://brew.sh):

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
