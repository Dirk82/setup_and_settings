#!/bin/bash

# Homebrew
if type brew &> /dev/null; then
  echo "=== Updating Homebrew and packages ==="
  brew update
  brew upgrade --all
  echo "=== Finished updating Homebrew and packages ==="
  echo
fi

# LaTeX
if type tlmgr &> /dev/null; then
  echo "=== Updating LaTeX ==="
  tlmgr update --self --all
  echo "=== Finished updating LaTeX ==="
  echo
fi

# Node, npm
if type npm &> /dev/null; then
  echo "=== Updating node packages  ==="
  npm -g update
  echo "=== Finished updating node packages ==="
  echo
fi

# RBENV
if type rbenv &> /dev/null; then
  echo "=== Updating rbenv and plugins  ==="
  cd $RBENV_ROOT
  git pull

  find $RBENV_PLUGINS -type d -name .git \
  | xargs -n 1 dirname \
  | sort \
  | while read line; do echo $line && cd $line && git pull; done

  rbenv rehash

  cd $HOME
  echo "=== Finished updating rbenv and plugin ==="
  echo
fi

# Python
if type pip &> /dev/null; then
  echo "=== Updating python packages (pip)  ==="
  pip install --upgrade pip
  pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U
  echo "=== Finished updating python packages (pip) ==="
  echo
fi

if type pip3 &> /dev/null; then
  echo "=== Updating python3 packages (pip3)  ==="
  pip3 install --upgrade pip
  pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip3 install -U
  echo "=== Finished updating python packages (pip3) ==="
  echo
fi
