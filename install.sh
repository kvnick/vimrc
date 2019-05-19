#!/bin/sh

#variables
INSTALL_DIR=$(pwd)

# check if ~/.vimrc file already exists
if [ -f ~/.vimrc ]; then
    echo '~/.vimrc file already exists'
    exit
fi

# check if ~/.vim directory already exists
if [ -d ~/.vim ]; then
    echo '~/.vim directory already exists'
    exit
fi

# check if git installed
if git --version 2&> /dev/null; then
    git submodule init
    git submodule update
else
    echo 'git is not installed'
fi

ln -s "$INSTALL_DIR/vimrc" ~/.vimrc
ln -s "$INSTALL_DIR/vim" ~/.vim

echo "vim configuration successfully installed"
