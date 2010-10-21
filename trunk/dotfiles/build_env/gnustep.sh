#! /bin/bash
#------------------------------------------------------------------------------
# gnustep.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id: gnustep.sh,v 1.4 2009/11/26 00:06:35 john Exp $
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
