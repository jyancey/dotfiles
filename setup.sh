#! /bin/sh
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

# Let's check to make sure everything is installed and we are ready to go. This
# assumes that the MacPort system has been installed in '/usr/local' and the
# base packages listed in '${pkg_base[@]}' have also been installed.
function do_check(){
  PHOME=/usr/local/var/macports/sources/rsync.macports.org/macports/release/tarballs
  pkg_base=(
    coreutils \
    cowsay \
    diffutils \
    figlet \
    findutils \
    fortune \
    macportsscripts \
    osxutils \
    tree \
   )
  echo "One second while I test things out..."
  if [[ -x /usr/local ]]; then
    printf " Install prefix '/usr/local' exists.\t\t[OK]\n"
  else
    printf " Missing install prefix '/usr/local'.\t[FAIL]\n"
    exit
  fi
  if [[ ${OS_SYS} == 'Darwin' ]]; then
    if [[ -x ${PHOME} ]]; then
      printf " MacPorts instalation exists.\t\t\t[OK]\n"
    else
      printf " MacPorts instalation missing.\t\t\t[FAIL]\n"
      exit
    fi
    if [[ -x /usr/local/bin/port ]]; then
      printf " MacPorts port command exists.\t\t\t[OK]\n"
    else
      printf " MacPorts port missing exists.\t\t\t[FAIL]\n"
      exit
    fi
    for pkg in "${pkg_base[@]}"; do
      if [[ `port installed | grep ${pkg}` ]]; then
          printf " MacPorts package %-15s installed.\t[OK]\n" "${pkg}"
      else
          printf " MacPorts package %-15s missing.\t[FAIL]\n" "${pkg}"
          exit
      fi
    done
  fi
  return
}

# Small cheat to clean all the dotfiles up if you want to do a hard
# reset of the symlinks.
function do_reset(){
  printf "Removing symlinks in ${HOME}\n"
  for file in "${dot_files[@]}"; do
    if [[ -e "$HOME/.$file" ]]; then
	  printf " removing ${HOME}/.%s \n" "$file"
      rm $HOME/.$file
	fi
  done
  return
}

# This assumes that the dotfiles repo is checked out into the
# $HOME/lib/dotfiles directory. This will create the following
# symlinks and directories if they do not exist:
#  $HOME/lib/dotfiles/shellrc          => ~/.bashrc
#  $HOME/lib/dotfiles/bash_logout      => ~/.bash_logout
#  $HOME/lib/dotfiles/dir_colors       => ~/.dir_colors
#  $HOME/lib/dotfiles/hgignore_global  => ~/.hgignore_global
#  $HOME/lib/dotfiles/ident.pro        => ~/.ident.pro
#  $HOME/lib/dotfiles/gitconfig        => ~/.gitconfig
#  $HOME/lib/dotfiles/gitignore_global => ~/.gitignore_global
#  $HOME/lib/dotfiles/npmrc            => ~/.npmrc
#  $HOME/lib/dotfiles/profile          => ~/.profile
#  $HOME/lib/dotfiles/zprofile         => ~/.zprofile
#  $HOME/lib/dotfiles/shellrc          => ~/.zshrc
#  $HOME/lib/dotfiles/zsh_logout       => ~/.zlogout
function do_file_link(){
  printf "Setting up symlinks in ${HOME} if needed...\n"
  for file in "${dot_files[@]}"; do
    if [[ ! -L "$HOME/.$file" ]]; then
      if [[ ${file} == "profile" || ${file} == "zshrc" ]];then
        printf " linking %-16s => $HOME/lib/dotfiles/shellrc\n" "$file"
        ln -fs $HOME/lib/dotfiles/shellrc $HOME/.$file
      else
        printf " linking %-16s => $HOME/lib/dotfiles/%s\n" "$file" "$file"
        ln -fs $HOME/lib/dotfiles/$file $HOME/.$file
      fi
	fi
  done
  return
}

usage(){
  printf "Usage: setup.sh [-r]\n"
  printf "  create the needed symliks in the home directory if missing.\n\n"
  printf "  checks that MacPorts and base packages are installed, \n"
  printf "  if host system is Darwin (macOS).\n"
  printf "  Options\n"
  printf "    -r resets the symlinks\n\n"
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
  do_check
  do_file_link
fi
shift $((OPTIND-1))
printf "Done!\n\n"
exit 0
