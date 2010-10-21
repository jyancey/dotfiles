#! /bin/bash
#------------------------------------------------------------------------------
# iosenv.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Set up IOS build environment 
# 
if [ "${IOS_ENV}" == "SET" ]; then
	echo "IOS build environment already setup!"
	return
fi

echo "Setting up IOS environment..."

IOS_ENV="SET"

# Save the old path.
IOS_OLDPATH=$PATH

# Image placment variables.
TFTPDIR=/ws/joyancey/images
TFTPHOST=""
COLON=""
COPY=/bin/cp

# Teambuilder
DATE=`date "+%Y%m%d"`
TIME_STAMP=`hostname`-$DATE
TEAMBUILDER_SYSTEM="cisco:cross"
TEAMBUILDER_CPP_EXTNS=".ii"
TEAMBUILDER_DEBUG=0
TEAMBUILDER_LOG=/ws/$LOGNAME/logs/TB-$TIME_STAMP.log
TEAMBUILDER_RELPATH=1

# Source ccache
if [ -f /sw/packages/ccache/current/bin/setup-ccache ]; then
  . /sw/packages/ccache/current/bin/setup-ccache
fi

PATH=/opt/teambuilder/bin:/router/bin:${PATH}

export TEAMBUILDER_SYSTEM TEAMBUILDER_CPP_EXTNS TEAMBUILDER_DEBUG 
export TEAMBUILDER_LOG TEAMBUILDER_RELPATH PATH IOS_OLDPATH
export TFTPDIR TFTPHOST COPY COLON IOS_ENV

#------------------------------------------------------------------------------
