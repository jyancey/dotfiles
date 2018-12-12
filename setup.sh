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
#    npmrc        -->  ~/.files/npmrc

dotFiles=( profile bash_profile bashrc bash_logout dir_colors vimrc vim_runtime gitconfig gitignore_global npmrc )

echo "Setting up:"
for file in "${dotFiles[@]}"; do
	if [ ! -L "$HOME/.$file" ]; then
		echo " --> $file"
	    ln -fs $HOME/.files/$file $HOME/.$file
	fi
done
echo "Done!"
