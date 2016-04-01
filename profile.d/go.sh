#! /bin/bash
#------------------------------------------------------------------------------
# go.sh - Dotfiles.
#
# Copyright (c) 2015 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------

if [ -x "/usr/local/go" ]; then
  GOROOT=/usr/local/go
fi

if [ -x "/Users/joyancey/Development/goprojects" ]; then
  GOPATH=/Users/joyancey/Development/GoProjects
elif [ -x "/nfs/source/GoProjects" ]; then
  GOPATH=/nfs/source/GoProjects
fi
declare -x GOROOT GOPATH
