#! /bin/bash
#------------------------------------------------------------------------------
# dirmarks.sh - Dotfiles.
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
# Copyright (c) 2000-2011 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.w.yancey@gmail.com>
#
# $Id:$
#------------------------------------------------------------------------------
#
if [ "$DEBUG" ]; then
  echo "-------> setting up bookmarks"
fi

# USAGE:
# bm -a bookmarkname - saves the curr dir as bookmarkname
# bm -g bookmarkname - jumps to the that bookmark
# bm -g b[TAB] - tab completion is available
# bm -p bookmarkname - prints the bookmark
# bm -p b[TAB] - tab completion is available
# bm -d bookmarkname - deletes the bookmark
# bm -d [TAB] - tab completion is available
# bm -l - list all bookmarks

# setup file to store bookmarks
if [ ! -n "$DMKRS" ]; then
    DMKRS=~/.dirmarks
fi
touch "$DMKRS"

# main function
function dm {
  option="${1}"
  case ${option} in
    # save current directory to bookmarks [ bm -a BOOKMARK_NAME ]
    -a)
      _save_bookmark "$2"
    ;;
    # delete bookmark [ bm -d BOOKMARK_NAME ]
    -d)
      _delete_bookmark "$2"
    ;;
    # jump to bookmark [ bm -g BOOKMARK_NAME ]
    -g)
      _goto_bookmark "$2"
    ;;
    # print bookmark [ bm -p BOOKMARK_NAME ]
    -p)
      _print_bookmark "$2"
    ;;
    # show bookmark list [ bm -l ]
    -l)
      _list_bookmark
    ;;
    # help [ bm -h ]
    -h)
      _echo_usage
    ;;
    *)
      if [[ $1 == -* ]]; then
        # unrecognized option. echo error message and usage [ bm -X ]
        echo "Unknown option '$1'"
        _echo_usage
        kill -SIGINT $$
        exit 1
      elif [[ $1 == "" ]]; then
        # no args supplied - echo usage [ bm ]
        _echo_usage
      else
        # non-option supplied as first arg.  assume goto [ bm BOOKMARK_NAME ]
        _goto_bookmark "$1"
      fi
    ;;
  esac
}

# print usage information
function _echo_usage {
  echo 'USAGE:'
  echo "dm -h                   - Prints this usage info"
  echo 'dm -a <bookmark_name>   - Saves the current directory as "bookmark_name"'
  echo 'dm [-g] <bookmark_name> - Goes (cd) to the directory associated with "bookmark_name"'
  echo 'dm -p <bookmark_name>   - Prints the directory associated with "bookmark_name"'
  echo 'dm -d <bookmark_name>   - Deletes the bookmark'
  echo 'dm -l                   - Lists all available bookmarks'
}

# save current directory to bookmarks
function _save_bookmark {
  _bookmark_name_valid "$@"
  if [ -z "$exit_message" ]; then
    _purge_line "$DMKRS" "export DIR_$1="
    CURDIR=$(echo $PWD| sed "s#^$HOME#\$HOME#g")
    echo "export DIR_$1=\"$CURDIR\"" >> $DMKRS
  fi
}

# delete bookmark
function _delete_bookmark {
  _bookmark_name_valid "$@"
  if [ -z "$exit_message" ]; then
    _purge_line "$DMKRS" "export DIR_$1="
    unset "DIR_$1"
  fi
}

# jump to bookmark
function _goto_bookmark {
    source $DMKRS
    target="$(eval $(echo echo $(echo \$DIR_$1)))"
    if [ -d "$target" ]; then
        cd "$target"
    elif [ ! -n "$target" ]; then
        printf '%s\n' "WARNING: '${1}' dirmark does not exist"
    else
        printf '%s\n' "WARNING: '${target}' does not exist"
    fi
}

# list bookmarks with dirname
function _list_bookmark {
    source $DMKRS
    # if color output is not working for you, comment out the line below '\033[1;32m' == "red"
    env | sort | awk '/DIR_.+/{split(substr($0,5),parts,"="); printf("\033[0;33m%-20s\033[0m %s\n", parts[1], parts[2]);}'
    # uncomment this line if color output is not working with the line above
    # env | grep "^DIR_" | cut -c5- | sort |grep "^.*="
}

# print bookmark
function _print_bookmark {
    source $DMKRS
    echo "$(eval $(echo echo $(echo \$DIR_$1)))"
}

# list bookmarks without dirname
function _l {
    source $DMKRS
    env | grep "^DIR_" | cut -c5- | sort | grep "^.*=" | cut -f1 -d "="
}

# validate bookmark name
function _bookmark_name_valid {
    exit_message=""
    if [ -z $1 ]; then
        exit_message="dirmark name required"
        echo $exit_message
    elif [ "$1" != "$(echo $1 | sed 's/[^A-Za-z0-9_]//g')" ]; then
        exit_message="dirmark name is not valid"
        echo $exit_message
    fi
}

# safe delete line from sdirs
function _purge_line {
  if [ -s "$1" ]; then
    # safely create a temp file
    t=$(mktemp -t dirmarks.XXXXXX) || exit 1
    trap "/bin/rm -f -- '$t'" EXIT

    # purge line
    sed "/$2/d" "$1" >| "$t"
    /bin/mv "$t" "$1"

    # cleanup temp file
    /bin/rm -f -- "$t"
    trap - EXIT
  fi
}

alias s='dm -a'       # Save a dirmark [dirmark_name]
alias g='dm -g'       # Go to dirmark [bookmark_name]
alias p='dm -p'       # Print dirmark of a path [path]
alias d='dm -d'       # Delete a dirmark [dirmark_name]
