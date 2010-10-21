#! /bin/bash
#------------------------------------------------------------------------------
# iweenv.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id: iweenv.sh,v 1.4 2010/04/09 20:36:43 john Exp $
#------------------------------------------------------------------------------
#
# Build environment setup to build IWE.
#
if [ "${IWE_ENV}" == "SET" ]; then
    echo "IWE build environment already setup!"
    return
fi

echo "Setting up IWE build environment..."

IWE_ENV="SET"

# Save the path!
IWE_OLDPATH=${PATH}

# Setting that are tooling related more than anything.
IWEREL="1.0.0"
IWE_HOME=/auto/iwe
CWTOOLS=/auto/cwtools

# Make sure we are using the IBM version of javac
if [ -x ${IWE_HOME}/bin/javac ]; then
    JAVA_HOME=${IWE_HOME}
fi

# Set ant home
if [ -x ${IWE_HOME}/bin/ant ]; then
    ANT_HOME=${IWE_HOME}
fi

# Set up the cvs information.
CVS_METHOD=pserver
CVS_USER=joyancey
CVS_SERVER=repository.cisco.com
CVS_PATH=/opt/cvsroot/Repository

CVSROOT=:${CVS_METHOD}:${CVS_USER}@${CVS_SERVER}:${CVS_PATH}

EDITOR=vi
VISUAL=${EDITOR}
SVN_EDITOR=${EDITOR}

# Add in the IWE path's
if [ -f "${CWTOOLS}/cwshrc.sh" ]; then
    . ${CWTOOLS}/cwshrc.sh
fi

PATH=${IWE_HOME}/bin:${PATH}:/opt/httpd/tools61/


export IWE_ENV IWE_HOME PATH IWE_OLDPATH IWEREL JAVA_HOME ANT_HOME CVSROOT
export VISUAL EDITOR SVN_EDITOR CWTOOLS

#------------------------------------------------------------------------------
