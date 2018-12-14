#! /bin/sh
#------------------------------------------------------------------------------
# setup.sh - Create symlink to dot files in home dir.
#
# Copyright (c) 2000-2018 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# This assumes that the dotfiles repo is checked out into the $HOME/.files 
# directory. This will create the following symlinks and directories if they
# do not exist:
#    $HOME/.files/bashrc       -->  ~/.profile
#    $HOME/.files/bash_logout  -->  ~/.files/bash_logout
#    $HOME/.files/bash_profile -->  ~/.profile
#    $HOME/.files/dir_colors   -->  ~/.files/dir_colors
#    $HOME/.files/gitconfig    -->  ~/.gitconfig
#    $HOME/.files/npmrc        -->  ~/.files/npmrc
#    $HOME/.files/profile      -->  ~/.files/bash_profile
#    $HOME/.files/vimrc        -->  ~/.files/vimrc
#    $HOME/.files/vim_runtime  -->  ~/.vim_runtime

dotFiles=(
    bashrc \
    bash_logout \
    bash_profile \
    dir_colors \
    gitconfig \
    gitignore_global \
    npmrc \
    profile \
    vimrc \
    vim_runtime
)

echo "Setting up:"
for file in "${dotFiles[@]}"; do
	if [ ! -L "$HOME/.$file" ]; then
		echo " --> $file"
	    ln -fs $HOME/.files/$file $HOME/.$file
	fi
done
echo "Done!"
