#! /bin/bash
#------------------------------------------------------------------------------
# jdsenv.sh - Dotfiles.
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
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
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

