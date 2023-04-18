#! /bin/bash
#------------------------------------------------------------------------------
# ecs.sh - Dotfiles.
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
# Copyright (c) 2000-2011 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
if [ "$DEBUG" ]; then
  echo "-------> setting up ecs"
fi

# Add strange Engenieering Computer Systems stuff here
CVSROOT=:pserver:john@sjc-joyancey-8717:/var/cvs
CVSIGNORE=path-jump.lst
CVS_RSH=ssh
#PRINTER=sjc24-03-c305-c
#LPDEST=$PRINTER
#MOZ_PRINTER_NAME=$PRINTER
declare -x CVSROOT CVSIGNORE CVS_RSH PRINTER LPDEST MOZ_PRINTER_NAME
