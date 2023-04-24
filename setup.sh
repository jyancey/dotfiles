#! /bin/sh
#------------------------------------------------------------------------------
# setup.sh - Create symlink to dot files in home dir.
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license in  the LICENSE file
# or https://opensource.org/license/cddl-1-0/
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
# Copyright (c) 2000-2023 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.w.yancey@gmail.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# This assumes that the dotfiles repo is checked out into the $HOME/.files
# directory. This will create the following symlinks and directories if they
# do not exist:
#    $HOME/.files/bashrc            -->  ~/.bashrc
#    $HOME/.files/bash_logout       -->  ~/.bash_logout
#    $HOME/.files/bash_profile      -->  ~/.profile
#    $HOME/.files/dir_colors        -->  ~/.dir_colors
#    $HOME/.files/hgignore_global   -->  ~/.hgignore_global
#    $HOME/.files/ident.pro         -->  ~/.ident.pro
#    $HOME/.files/gitconfig         -->  ~/.gitconfig
#    $HOME/.files/gitignore_global  -->  ~/.gitignore_global
#    $HOME/.files/npmrc             -->  ~/.npmrc
#    $HOME/.files/profile           -->  ~/.profile
#    $HOME/.files/vimrc             -->  ~/.vimrc
#    $HOME/.files/vim_runtime       -->  ~/.vim_runtime

dotFiles=(
    bashrc \
    bash_logout \
    bash_profile \
    dir_colors \
    hgignore_global \
    indent.pro \
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
