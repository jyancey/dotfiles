#! /bin/bash
#------------------------------------------------------------------------------
# manpath.sh - Dotfiles.
#
# Copyright (c) 2000-2011 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Functions to help manage manpaths.  Second argument is the name of the
# manpath variable to be modified (default: MANPATH)
#
manpathremove () {
    local IFS=':'
    local NEWMANPATH
    local DIR
    local MANPATHVARIABLE=${2:-MANPATH}
    for DIR in ${!MANPATHVARIABLE} ; do
            if [ "$DIR" != "$1" ] ; then
              NEWMANPATH=${NEWMANPATH:+$NEWMANPATH:}$DIR
            fi
    done
    declare -x $MANPATHVARIABLE="$NEWMANPATH"
}

manpathprepend () {
    manpathremove $1 $2
    local MANPATHVARIABLE=${2:-MANPATH}
    declare -x $MANPATHVARIABLE="$1${!MANPATHVARIABLE:+:${!MANPATHVARIABLE}}"
}

manpathappend () {
    manpathremove $1 $2
    local MANPATHVARIABLE=${2:-MANPATH}
    declare -x $MANPATHVARIABLE="${!MANPATHVARIABLE:+${!MANPATHVARIABLE}:}$1"
}

# Set the inital MANPATH
MANPATH=/usr/man

# Scream over all the manpaths listed in the 'manpaths' file.
for DIRS in `cat $HOME/.files/manpaths`; do
    # echo "$DIRS..."
    if [ -d "$DIRS" ]; then
        manpathappend $DIRS
    fi
done

# Now to clean up
unset manpathremove manpathprepend manpathappend

declare -x MANPATH=$MANPATH:${HOME}/man
