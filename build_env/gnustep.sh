#! /bin/bash
#------------------------------------------------------------------------------
# gnustep.sh - Dotfiles.
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
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Build environment setup to build GNUStep programs.
#
if [ "$GNUSTEP_ENV" == "SET" ]; then
    echo "GNUStep build environment already setup!"
    return
fi
if [ "$OS_SYS" == "Darwin" ]; then
    echo "No need to set this up for $OS_SYS."
    return
fi
echo -n "Setting up GNUStep environment..."

GNUSTEP_ENV="SET"

# Save the old path.
GNUSTEP_OLDPATH=$PATH

# Start looking for the GNUStep.sh file, it's different on Ubuntu and Fedora
if [[ "$OS_DIST" =~ "Fedora" ]]; then
    echo "for $OS_DIST."
    if [ -f /usr/lib/GNUstep/Makefiles/GNUstep.sh ]; then
        . /usr/lib/GNUstep/Makefiles/GNUstep.sh
    elif [ -f /usr/lib64/GNUstep/Makefiles/GNUstep.sh ]; then
        . /usr/lib64/GNUstep/Makefiles/GNUstep.sh
    fi
elif [[ "$OS_DIST" =~ "Ubuntu" ]]; then
    echo "for $OS_DIST."
    if [ -f /usr/share/GNUstep/Makefiles/GNUstep.sh ]; then
       . /usr/share/GNUstep/Makefiles/GNUstep.sh
    fi
fi
