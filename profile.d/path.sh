#! /bin/bash
#------------------------------------------------------------------------------
# path.sh - Dotfiles.
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
# $Id$
#------------------------------------------------------------------------------
#
if [ "$DEBUG" ]; then
  echo "-------> setting up path"
fi

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
for DIRS in `cat $HOME/.files/lib/paths`; do
    if [ "$DEBUG" ]; then
        echo "-------> $DIRS..."
    fi
    if [ -d "$DIRS" ]; then
        if [ "$DEBUG" ]; then
            echo "-----------> appending $DIRS to path."
        fi
        pathappend $DIRS
    fi
done

# Now to clean up
unset pathremove pathprepend pathappend

declare -x PATH
