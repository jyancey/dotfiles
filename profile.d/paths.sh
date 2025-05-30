#! /bin/bash
#------------------------------------------------------------------------------
# paths.sh - Dotfiles.
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
# August 2000 John Yancey <john.w.yancey@gmail.com>
#
# $Id$
#------------------------------------------------------------------------------
#

# Scream over all the paths listed in the 'paths,' 'manpaths' and 'infopaths'
# filses located in the $HOME/.files/lib/(man|info|paths) files. We are using
# a modified version of the 'path_helper' command, see the my_path_helper.c 
# source file in the dotfile repo to see how it works.
if [ -x ${HOME}/bin/path_helper ]; then
  if [ "$DEBUG" ]; then
    echo "-------> setting up paths"
  fi
	eval `${HOME}/bin/path_helper -s`
fi

declare -x PATH
