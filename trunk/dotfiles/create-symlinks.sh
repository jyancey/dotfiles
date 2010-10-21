#! /bin/sh
#------------------------------------------------------------------------------
# create_symlinks.sh - Dotfiles create symlink to file in home dir.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id: create-symlinks.sh,v 1.3 2010/03/05 20:59:56 john Exp $
#------------------------------------------------------------------------------
#
# Need to crearte the following symlinks if they do not exist:
#    .profile      -> .files/bash_profile
#    .bash_profile -> .profile
#    .bashrc       -> .profile
#    .bash_logout  -> .files/bash_logout
#    .dir_colors   -> .files/dir_colors

if [ ! -L "$HOME/.profile" ]; then
    ln -fs $HOME/.files/bash_profile $HOME/.profile
fi 

if [ ! -L "$HOME/.bash_profile" ]; then
    ln -fs $HOME/.profile $HOME/.bash_profile
fi 

if [ ! -L "$HOME/.bashrc" ]; then
    ln -fs $HOME/.profile $HOME/.bashrc
fi 

if [ ! -L "$HOME/.bash_logout" ]; then
    ln -fs $HOME/.files/bash_logout $HOME/.bash_logout
fi 

if [ ! -L "$HOME/.dir_colors" ]; then
    ln -fs $HOME/.files/dir_colors $HOME/.dir_colors
fi 
