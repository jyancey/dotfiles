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
  export GOROOT=/usr/local/go
elif [ -x "/sw/lib/go" ]; then
  export GOROOT=/sw/lib/go
fi

if [ -x "${GOPATH}/bin" ]; then
  export PATH=${PATH}:${GOPATH}/bin
fi

if [ -x "${HOME}/WorkSpace/golang" ]; then
  export GOPATH=${HOME}/WorkSpace/golang
fi

