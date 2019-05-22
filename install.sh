#!/bin/sh

#variables
INSTALL_DIR=$(pwd)

# check if ~/.vimrc file already exists
if [ -f $HOME/.vimrc ]; then
    echo "$HOME/.vimrc file already exists"
    exit
fi

# check if ~/.vim directory already exists
if [ -d $HOME/.vim ]; then
    echo "$HOME/.vim directory already exists"
    exit
fi

# check if git installed
if git --version 2&> /dev/null; then
    git submodule init
    git submodule update
else
    echo 'git is not installed'
    exit
fi

ln -s "$INSTALL_DIR/vimrc" $HOME/.vimrc
ln -s "$INSTALL_DIR/vim" $HOME/.vim

echo "vim configuration successfully installed"
