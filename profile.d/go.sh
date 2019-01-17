#! /bin/bash
#------------------------------------------------------------------------------
# go.sh - Dotfiles.
#
# Copyright (c) 2015-2018 by John Yancey, All rights reserved.
#
# August 2015 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------

if [ -x "/usr/local/go" ]; then
  export GOROOT=/usr/local/go
  export PATH=${PATH}:/usr/local/go/bin
elif [ -x "/sw/lib/go" ]; then
  export GOROOT=/sw/lib/go
fi

if [ -x "${HOME}/WorkSpace/golang" ]; then
  export GOPATH=${HOME}/WorkSpace/golang
fi

