#! /bin/bash
#------------------------------------------------------------------------------
# go.sh - Dotfiles.
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license in  the LICENSE file
# or https://opensource.org/license/cddl-1-0/
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
# Copyright (c) 2015-2018 by John Yancey, All rights reserved.
#
# August 2015 John Yancey <john.w.yancey@gmail.com>
#
# $Id$
#------------------------------------------------------------------------------
if [ "$DEBUG" ]; then
  echo "-------> setting up golang"
fi

if [[ "${OS_PLATFORM}" == "x86_64" ]]; then
  export GOARCH=x86_64
else
  export GOARCH=amd64
fi

if [[ "${OS_SYS}" == "Darwin" ]]; then
  export GOOS=darwin
  export GOARCH=arm64
  if [ -x /opt/macports/lib/go ]; then
    export GOROOT=/opt/macports/lib/go
  fi
  if [ -x "${HOME}/lib/go" ]; then
    export GOPATH=$HOME/lib/go
  fi
  if [ -x "${HOME}/bin" ]; then
    export GOBIN=${HOME}/bin
  fi
  export PATH=$PATH:$GOBIN
  export GO11MODULES=on  # Recommended for new projects
  export GOPROXY=https://proxy.golang.org,direct
  export GOCACHE='/Users/john/Library/Caches/go-build'
fi
