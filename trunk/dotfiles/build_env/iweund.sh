#! /bin/bash
#------------------------------------------------------------------------------
# iweund.sh - Undo the IWE Environment
#
# Copyright (c) 2000-2010 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Clean up IWE build environment.
#
echo "Cleaning up IWE environment..."

IWE_ENV=0

PATH=${IWE_OLDPATH}
unset IWE_OLDPATH

# Unset tooling related env.
unset IWEREL
unset IWE_HOME
unset CWTOOLS
unset JAVA_HOME
unset ANT_HOME
unset CVS_METHOD
unset CVS_USER
unset CVS_SERVER
unset CVS_PATH
unset CVSROOT
unset EDITOR
unset VISUAL
unset SVN_EDITOR

export PATH IWE_ENV

#------------------------------------------------------------------------------
