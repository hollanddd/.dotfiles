#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -sw $HOME/.dotfiles/.zshrc $HOME/.zshrc

# configure git configs
rm $HOME/.gitconfig
ln -sw $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

rm $HOME/.gitignore
ln -sw $HOME/.dotfiles/.gitignore_global $HOME/.gitignore_global

# Check for tmux config directory and create if it doesn't exist
if [ ! -d $HOME/.config/tmux ]; then
  mkdir -p $HOME/.config/tmux
fi
# remove existing tmux config file and symlink the .tmux.conf file from the .dotfiles
rm -rf $HOME/.config/tmux/tmux.conf
ln -sw $HOME/.dotfiles/tmux.conf $HOME/.config/tmux/tmux.conf

# remove existing finicky config file and symlink the .finicky.js file from the .dotfiles
rm -rf $HOME/.finicky.js
ln -sw $HOME/.dotfiles/finicky.js $HOME/.finicky.js

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew bundle --file ./Brewfile

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
