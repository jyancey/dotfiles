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
# Copyright (c) 2000-2026 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.w.yancey@gmail.org>
#
# $Id$
#------------------------------------------------------------------------------
#
dotfiles_dir="$(cd "$(dirname "$0")" && pwd -P)"

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
  zshrc \
  zprofile
)

# Small cheat to clean all the dotfiles up if you want to do a hard
# reset of the symlinks.
function do_reset(){
  printf "Removing symlinks in %s\n" "${HOME}"
  for file in "${dot_files[@]}"; do
    link_path="${HOME}/.${file}"
    if [[ -L "${link_path}" ]]; then
      printf " removing %s\n" "${link_path}"
      command rm "${link_path}"
    fi
  done
  return
}

# Link shell startup files to the shared configuration and other dotfiles to
# their matching repository files. Existing regular files are preserved.
function do_file_link(){
  printf "Setting up symlinks in %s if needed...\n" "${HOME}"
  for file in "${dot_files[@]}"; do
    link_path="${HOME}/.${file}"
    case "${file}" in
      bash_profile|bashrc|profile|zshrc)
        source_path="${dotfiles_dir}/shellrc"
        ;;
      *)
        source_path="${dotfiles_dir}/${file}"
        ;;
    esac

    if [[ ! -e "${source_path}" ]]; then
      printf " missing source for .%s: %s\n" "${file}" "${source_path}" >&2
      continue
    fi

    if [[ -L "${link_path}" ]]; then
      if [[ "$(readlink "${link_path}")" == "${source_path}" ]]; then
        continue
      fi
      printf " updating .%s => %s\n" "${file}" "${source_path}"
      command ln -sfn "${source_path}" "${link_path}"
    elif [[ -e "${link_path}" ]]; then
      printf " preserving existing file %s\n" "${link_path}"
    else
      printf " linking .%-16s => %s\n" "${file}" "${source_path}"
      command ln -s "${source_path}" "${link_path}"
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
