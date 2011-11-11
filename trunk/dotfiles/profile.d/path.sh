#! /bin/bash
#------------------------------------------------------------------------------
# path.sh - Dotfiles.
#
# Copyright (c) 2000-2011 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Functions to help manage paths.  Second argument is the name of the
# path variable to be modified (default: PATH)
#
pathremove () {
    local IFS=':'
    local NEWPATH
    local DIR
    local PATHVARIABLE=${2:-PATH}
    for DIR in ${!PATHVARIABLE} ; do
            if [ "$DIR" != "$1" ] ; then
              NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
            fi
    done
    export $PATHVARIABLE="$NEWPATH"
}

pathprepend () {
    pathremove $1 $2
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend () {
    pathremove $1 $2
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

# Set the inital PATH
PATH=/bin:/usr/bin

# Scream over all the paths listed in the 'paths' file.
for DIRS in `cat $HOME/.files/paths`; do
    # echo "$DIRS..."
    if [ -d "$DIRS" ]; then
        pathappend $DIRS
    fi
done

# Now to clean up
unset pathremove pathprepend pathappend

declare -x PATH=$PATH:${HOME}/bin
