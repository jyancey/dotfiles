#! /bin/bash
#------------------------------------------------------------------------------
# jdsenv.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id: jdsenv.sh,v 1.2 2009/11/26 00:06:35 john Exp $
#------------------------------------------------------------------------------
#
# Strange build Vars.
# Do build environment setup for JDS if we are on a Solaris 5.11 system
# and there is a /opt/jdsbld directort.
#
echo "Setting up JDS environment..."

if [ "$OS_SYS" == "SunOS" -a "$OS_REL" == "5.11" ]; then
    if [ -d /opt/jdsbld -a -d /opt/SUNWspro ]; then
      export JDS_CBE_ENV_QUIET=1; . /opt/jdsbld/bin/env.sh
    fi
fi

#------------------------------------------------------------------------------

