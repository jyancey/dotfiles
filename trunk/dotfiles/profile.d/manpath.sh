#! /bin/bash
#------------------------------------------------------------------------------
# manpath.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id: manpath.sh,v 1.2 2009/11/26 00:06:36 john Exp $
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
    export $MANPATHVARIABLE="$NEWMANPATH"
}

manpathprepend () {
    manpathremove $1 $2
    local MANPATHVARIABLE=${2:-MANPATH}
    export $MANPATHVARIABLE="$1${!MANPATHVARIABLE:+:${!MANPATHVARIABLE}}"
}

manpathappend () {
    manpathremove $1 $2
    local MANPATHVARIABLE=${2:-MANPATH}
    export $MANPATHVARIABLE="${!MANPATHVARIABLE:+${!MANPATHVARIABLE}:}$1"
}

# Set the inital MANPATH
MANPATH=/usr/man

# Scream over all the manpaths listed in the 'manpaths' file.
for D in `cat $HOME/.files/manpaths`; do
    # echo "$D..."
    if [ -d "$D" ]; then
        manpathappend $D
    fi
done

# Now to clean up
unset manpathremove manpathprepend manpathappend

export MANPATH=$MANPATH:${HOME}/man
