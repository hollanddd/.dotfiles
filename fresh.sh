#!/bin/sh

name=$(uname)

echo "Setting up your $name machine..."

# Check for Oh My Zsh and install if we don't have it
if ! command -v omz >/dev/null 2>&1; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

if ! command -v rustc >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Check for Homebrew and install if we don't have it
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ "$name" = "Linux" ]; then
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# Update Homebrew recipes
brew update
    
# Install all our dependencies with bundle (See Brewfile)
brew bundle --file $HOME/.dotfiles/Brewfile

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# configure git configs
rm -rf $HOME/.gitconfig
ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

rm -rf $HOME/.gitignore
rm -rf $HOME/.gitignore_global
ln -s $HOME/.dotfiles/.gitignore_global $HOME/.gitignore_global

# Check for tmux config directory and create if it doesn't exist
if [ ! -d $HOME/.config/tmux ]; then
  mkdir -p $HOME/.config/tmux
fi

# remove existing tmux config file and symlink the .tmux.conf file from the .dotfiles
rm -rf $HOME/.config/tmux/tmux.conf
ln -s $HOME/.dotfiles/tmux.conf $HOME/.config/tmux/tmux.conf

rm -rf $HOME/.config/nvim
ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim

if [ "$name" = "Darwin" ]; then
  # remove existing finicky config file and symlink the .finicky.js file from the .dotfiles
  rm -rf $HOME/.finicky.js
  ln -s $HOME/.dotfiles/finicky.js $HOME/.finicky.js

  # Set macOS preferences - we will run this last because this will reload the shell
  . ./.macos
fi
