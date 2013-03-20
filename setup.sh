#! /bin/sh
#------------------------------------------------------------------------------
# create_symlinks.sh - Dotfiles create symlink to file in home dir.
#
# Copyright (c) 2000-2010 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Need to crearte the following symlinks and directories if they do not
# exist:
#    profile      -->  ~/.files/bash_profile
#    bash_profile -->  ~/.profile
#    bashrc       -->  ~/.profile
#    bash_logout  -->  ~/.files/bash_logout
#    dir_colors   -->  ~/.files/dir_colors
#    vimrc        -->  ~/.files/vimrc
#    vim_runtime  -->  ~/.vim_runtime
#    gitconfig    -->  ~/.gitconfig

echo "Setting up:"
echo " -->  profile"
if [ ! -L "$HOME/.profile" ]; then
    ln -fs $HOME/.files/bash_profile $HOME/.profile
fi

echo " -->  bash_profile"
if [ ! -L "$HOME/.bash_profile" ]; then
    ln -fs $HOME/.profile $HOME/.bash_profile
fi

echo " -->  bashrc"
if [ ! -L "$HOME/.bashrc" ]; then
    ln -fs $HOME/.profile $HOME/.bashrc
fi

echo " -->  bash_logout"
if [ ! -L "$HOME/.bash_logout" ]; then
    ln -fs $HOME/.files/bash_logout $HOME/.bash_logout
fi

echo " -->  dir_colors"
if [ ! -L "$HOME/.dir_colors" ]; then
    ln -fs $HOME/.files/dir_colors $HOME/.dir_colors
fi

echo " -->  vimrc"
if [ ! -L "$HOME/.vimrc" ]; then
    ln -fs $HOME/.files/vimrc $HOME/.vimrc
fi

echo " -->  vim_runtime"
if [ ! -d "$HOME/.vim_runtime" ]; then
    cp -vR $HOME/.files/vim_runtime $HOME/.vim_runtime
else
    rm -fr $HOME/.vim_runtime
    cp -R $HOME/.files/vim_runtime $HOME/.vim_runtime
fi

echo " -->  gitconfig"
if [ ! -L "$HOME/.gitconfig" ]; then
    ln -fs $HOME/.files/gitconfig $HOME/.gitconfig
fi

echo " -->  gitignore_global"
if [ ! -L "$HOME/.gitingore_global" ];then
    ln -fs $HOME/.files/gitignore_global $HOME/.gitignore_global
fi
echo "Done!"
