#! /bin/bash
#------------------------------------------------------------------------------
# google-cloud-sdk - Dotfiles.
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
# Copyright (c) 2000-2020 by John Yancey, All rights reserved.
#
# August 2020 John Yancey <john.w.yancey@gmail.com>
#
# $Id$
#------------------------------------------------------------------------------
if [ "$DEBUG" ]; then
  echo "-------> setting up google"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/lib/google-cloud-sdk/path.bash.inc" ]; then
    source "${HOME}/lib/google-cloud-sdk/path.bash.inc"
fi

# The next line enables shell command completion for gcloud.
if [ "${MYSHELL}" = "bash" ] &&
   [ -f "${HOME}/lib/google-cloud-sdk/completion.bash.inc" ]; then
    source "${HOME}/lib/google-cloud-sdk/completion.bash.inc"
fi
