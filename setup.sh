#! /usr/bin/env zsh
#------------------------------------------------------------------------------
# setup.sh - Create|Remove symlink to dot files in home dir.
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
dot_files=(
  bashrc \
  bash_profile \
  bash_logout \
  dir_colors \
  hgignore_global \
  indent.pro \
  gitconfig \
  gitignore_global \
  npmrc \
  profile \
  zprofile \
  zshrc \
  zlogout
)

# Small cheat to clean all the dotfiles up if you want to do a hard
# reset of the symlinks.
function do_reset(){
  printf "Removing symlinks in ${HOME}\n"
  for file in "${dot_files[@]}"; do
    if [[ -L "$HOME/.$file" ]]; then
	  printf " removing ${HOME}/.%s \n" "$file"
      rm ${HOME}/.${file}
	fi
  done
  return
}

# This assumes that the dotfiles repo is checked out into the
# $HOME/.config/dotfiles directory. This will create the following
# symlinks and directories if they do not exist:
#  $HOME/.config/dotfiles/shellrc          => ~/.bashrc
#  $HOME/.config/dotfiles/bash_profile     => ~/.bash_profile
#  $HOME/.config/dotfiles/bash_logout      => ~/.bash_logout
#  $HOME/.config/dotfiles/dir_colors       => ~/.dir_colors
#  $HOME/.config/dotfiles/hgignore_global  => ~/.hgignore_global
#  $HOME/.config/dotfiles/ident.pro        => ~/.ident.pro
#  $HOME/.config/dotfiles/gitconfig        => ~/.gitconfig
#  $HOME/.config/dotfiles/gitignore_global => ~/.gitignore_global
#  $HOME/.config/dotfiles/npmrc            => ~/.npmrc
#  $HOME/.config/dotfiles/profile          => ~/.profile
#  $HOME/.config/dotfiles/zprofile         => ~/.zprofile
#  $HOME/.config/dotfiles/shellrc          => ~/.zshrc
#  $HOME/.config/dotfiles/zsh_logout       => ~/.zlogout
function do_file_link(){
  printf "Setting up symlinks in ${HOME} if needed...\n"
  for file in "${dot_files[@]}"; do
    if [[ ! -L "$HOME/.$file" ]]; then
      if [[ ${file} == "profile" || ${file} == "zshrc" ]];then
        printf " linking .%-16s => $HOME/.config/dotfiles/shellrc\n" "$file"
        ln -fs ${HOME}/.config/dotfiles/shellrc ${HOME}/.${file}
      else
        printf " linking .%-16s => $HOME/.config/dotfiles/%s\n" "$file" "$file"
        ln -fs ${HOME}/.config/dotfiles/${file} ${HOME}/.${file}
      fi
	fi
  done
  return
}

usage(){
  printf "Usage: setup.sh [-r]\n"
  printf "  create the needed symliks in the home directory if missing.\n\n"
  printf "  Options:\n"
  printf "    -r removes the symlinks\n\n"
  exit 1
}

while getopts 'r' O; do
  case "${O}" in
    r) RFLAG=1 ;;
    *) usage ;;
  esac
done
if [[ "${RFLAG}" ]]; then
  do_reset
else
  do_file_link
fi
shift $((OPTIND-1))
printf "Done!\n\n"
exit 0
