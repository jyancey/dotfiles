#! /bin/bash
#------------------------------------------------------------------------------
# manpath.sh - Dotfiles.
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
# $Id$
#------------------------------------------------------------------------------
#
if [ "$DEBUG" ]; then
  echo "-------> setting up manpaths"
fi

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
for DIRS in `cat $HOME/.files/manpaths`; do
    # echo "$DIRS..."
    if [ -d "$DIRS" ]; then
        manpathappend $DIRS
    fi
done

# Now to clean up
unset manpathremove manpathprepend manpathappend

declare -x MANPATH=$MANPATH:${HOME}/man:${HOME}/.npm-packages/share/man
