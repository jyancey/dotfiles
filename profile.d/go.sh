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

if [ -x "${HOME}/Develop" ];then
  export DEVPATH=${HOME}/Develop
elif [ -x "${HOME}/Developer" ]; then
  export DEVPATH=${HOME}/Developer
fi

if [ -x "/usr/local/go" ]; then
  export GOROOT=/usr/local/go
  export PATH=${PATH}:/usr/local/go/bin
elif [ -x "/usr/local/lib/go" ]; then
  export GOROOT=/usr/local/lib/go
fi

if [ -x "${DEVPATH}" ]; then
  export GOPATH=${DEVPATH}/go
elif [ -x "${HOME}/go" ]; then
  export GOPATH=${HOME}/go
fi

if [ -x "${GOPATH}/bin" ]; then
  export PATH=${PATH}:${GOPATH}/bin
fi

