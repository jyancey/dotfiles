#! /bin/bash
#------------------------------------------------------------------------------
# bashmarks.sh - Dotfiles.
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
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id:$
#------------------------------------------------------------------------------
#
if [ "$DEBUG" ]; then
  echo "-------> setting up bookmarks"
fi

# maintains a set of "bookmarks" for directories you actually use
#
# USE:
#   * g foo     # go to dir matching bookmark foo
#   * d foo bar # display bookmarks matching foo and bar
#   * s foo     # save dir as bookmark foo
#   * r foo     # remove bookmark matching foo
#   * p foo     # push bookmark foo into directory stack
#   * sl        # display a list of boomarks

# If the repository of bookmarks does not exist, create it
if  [ ! -e $HOME/.dirmarks ]; then
    mkdir $HOME/.dirmarks
fi

# "s" - Save bookmark
function s () { 
    if [ -n "$2" ]; then
        # build the bookmark file with the contents "$CD directory_path"
        ( echo '$CD ' \"$2\" > $HOME/.dirmarks/"$1" ;) > /dev/null 2>&1
    else
        # build the bookmark file with the contents "$CD directory_path"
        ( echo -n '$CD ' > $HOME/.dirmarks/"$1" ; 
          pwd | sed "s/ /\\\\ /g" >> $HOME/.dirmarks/"$1" ; ) > /dev/null 2>&1
    fi

    # if the bookmark could not be created, print an error message and
    # exit with a failing return code
    if [ $? != 0 ]; then
        echo bash: dirmarks: $HOME/.dirmarks/"$1" could not be created >&2
        false
    fi
}

# "g" - Go to bookmark
function g () { 
    # if no arguments, then just go to the home directory
    if [ -z "$1" ]; then
        cd
    else
        # if $1 is in $HOME/.dirmarks and does not begin with ".", then go to it
        if [ -f $HOME/.dirmarks/"$1" -a ${1:0:1} != "." ]; then 
            # update the bookmark's timestamp and then execute it
            touch $HOME/.dirmarks/"$1" ; 
            CD=cd source $HOME/.dirmarks/"$1" ; 
        # else just do a "cd" to the argument, usually a directory path of "-"
        else
            cd "$1"
        fi
    fi
}

# "p" - Push a bookmark
function p () { 
    # Note, list the directory stack in a single  column.  Thus, the 
    # standard behavior of "pushd" and "popd" have been replaced by 
    # discarding the normal output of these commands and using a  "dirs -p" 
    # after each one.

    # if no argument given, then just pushd and print out the directory stack
    if [ -z "$1" ]; then
        pushd > /dev/null && dirs -p

    # if $1 is a dash, then just do a "popd" and print out the directory stack
    elif [ "$1" == "-" ]; then
        popd > /dev/null
        dirs -p
    else
        # if $1 is in $HOME/.dirmarks and does not begin with ".", then go to it
        # and then print out the directory stack
        if [ -f $HOME/.dirmarks/"$1" -a "${1:0:1}" != "." ]; then
            touch $HOME/.dirmarks/$1 ; 
            CD=pushd source $HOME/.dirmarks/$1 > /dev/null && dirs -p ; 

        # else just do a "pushd" and print out the directory stack
        else
            pushd "$1" > /dev/null && dirs -p
        fi
    fi
}

# "sl" - Saved bookmark Listing
function sl () { 
    # if the "-l" argument is given, then do a long listing, passing any 
    # remaining arguments to "ls", printing in reverse time order.  Pass the
    # output to "less" to page the output if longer than a screen in length.
    if [ "$1" == "-l" ]; then
        shift
        ( cd $HOME/.dirmarks ;
        ls -lt $* | 
            sed -e 's/  */ /g' -e '/^total/d' \
                -e 's/^\(... \)\([0-9] \)/\1 \2/' | 
            cut -d ' ' -s -f6- | sed -e '/ [0-9] /s// &/' | less -FX ; )

    # else print the short form of the bookmarks in reverse time order
    else
        ( cd $HOME/.dirmarks ; ls -xt $* ; )
    fi
}

# "r" - Remove a saved bookmark
function r () { 
    # if the bookmark file exists, remove it
    if [ -e $HOME/.dirmarks/"$1" ]; then
        rm $HOME/.dirmarks/"$1"

    # if the bookmark file does not exist, complain and exit with a failing code
    else
        echo bash: dirmarks: $HOME/.dirmarks/"$1" does not exist >&2
        false
    fi
}

# "d" - Display (or Dereference) a saved bookmark
# to use: cd "$(d xxx)"
function d () {  
    # if the bookmark exists, then extract its directory path and print it
    if [ -e $HOME/.dirmarks/"$1" ]; then
        sed -e 's/\$CD //' -e 's/\\//g' $HOME/.dirmarks/"$1"

    # if the bookmark does not exists, complain and exit with a failing code
    else
        echo bash: dirmarks: $HOME/.dirmarks/"$1" does not exist >&2
        false
    fi
}

# "mh" - Display dirmarks help
function mh (){
    echo "USE:"
    echo "  * g foo     # go to dir matching bookmark foo"
    echo "  * d foo bar # display bookmarks matching foo and bar"
    echo "  * s foo     # save dir as bookmark foo"
    echo "  * r foo     # remove bookmark matching foo"
    echo "  * p foo     # push bookmark foo into directory stack"
    echo "  * sl        # display a list of boomarks"
}
