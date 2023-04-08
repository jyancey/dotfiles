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

if [ "${OS_PLATFORM}" == "x86_64" ]; then
  export GOARCH=amd64
fi
if [ "${OS_SYS}" == "Darwin" ]; then
  export GOOS=darwin
fi

if [ -x /usr/local/lib/go ]; then
  export GOROOT=/usr/local/lib/go
fi
  
if [ -x "${HOME}/src" ]; then
  export GOPATH=${HOME}/src/go
fi

if [ -x "${HOME}/bin" ]; then
  export GOBIN=${HOME}/bin
fi
