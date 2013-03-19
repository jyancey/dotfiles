#! /bin/bash
#------------------------------------------------------------------------------
# infopath.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Functions to help manage infopaths.  Second argument is the name of the
# infopath variable to be modified (default: INFOPATH)
#
infopathremove () {
    local IFS=':'
    local NEWINFOPATH
    local DIR
    local INFOPATHVARIABLE=${2:-INFOPATH}
    for DIR in ${!INFOPATHVARIABLE} ; do
            if [ "$DIR" != "$1" ] ; then
              NEWINFOPATH=${NEWINFOPATH:+$NEWINFOPATH:}$DIR
            fi
    done
    export $INFOPATHVARIABLE="$NEWINFOPATH"
}

infopathprepend () {
    infopathremove $1 $2
    local INFOPATHVARIABLE=${2:-infoPATH}
    export $INFOPATHVARIABLE="$1${!INFOPATHVARIABLE:+:${!INFOPATHVARIABLE}}"
}

infopathappend () {
    infopathremove $1 $2
    local INFOPATHVARIABLE=${2:-INFOPATH}
    export $INFOPATHVARIABLE="${!INFOPATHVARIABLE:+${!INFOPATHVARIABLE}:}$1"
}

# Set the inital infoPATH
INFOPATH=/usr/info

# Scream over all the infopaths listed in the 'infopaths' file.
for D in `cat $HOME/.files/infopaths`; do
    # echo "$D..."
    if [ -d "$D" ]; then
        infopathappend $D
    fi
done

# Now to clean up
unset infopathremove infopathprepend infopathappend

export INFOPATH=$INFOPATH:${HOME}/info
