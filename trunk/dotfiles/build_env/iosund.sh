#! /bin/bash
#------------------------------------------------------------------------------
# iosund.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id: iosund.sh,v 1.2 2009/11/26 00:06:35 john Exp $
#------------------------------------------------------------------------------
#
# Clean up IOS build environment.
#
echo "Cleaning up IOS environment..."

IOS_ENV=0

PATH=${IOS_OLDPATH}
unset IOS_OLDPATH

# Image placment variables.
unset TFTPDIR
unset TFTPHOST
unset COLON
unset COPY

# Teambuilder
unset DATE
unset TIME_STAMP
unset TEAMBUILDER_SYSTEM
unset TEAMBUILDER_CPP_EXTNS
unset TEAMBUILDER_DEBUG
unset TEAMBUILDER_LOG
unset TEAMBUILDER_RELPATH

# ccache
unset CCACHE_PATH
unset CCACHE_TMPDIR
unset CCACHE_DIR
unset CCACHE_SETUP
unset CCACHE_GCC_FARM_PATH

export PATH IOS_ENV

#------------------------------------------------------------------------------
