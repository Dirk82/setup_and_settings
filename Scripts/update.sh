#!/bin/bash

# Homebrew
if type brew &> /dev/null; then
  echo "=== Updating Homebrew and packages ==="
  brew update
  brew upgrade
  echo "=== Finished updating Homebrew and packages ==="
  echo
fi

# Antigen bundles# ASDF
if type asdf &> /dev/null; then
  echo "=== Updating ASDF plugins  ==="
  asdf plugin update --all
  echo "=== Finished updating ASDF plugins ==="
  echo
fi

# Node, npm
if type npm &> /dev/null; then
  echo "=== Updating node packages  ==="
  npm -g update
  echo "=== Finished updating node packages ==="
  echo
fi
