#!/bin/bash

echo 'brew'
brew upgrade
brew cleanup

echo 'rust'
rustup update
