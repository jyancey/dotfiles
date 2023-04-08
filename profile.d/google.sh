#! /bin/bash
#------------------------------------------------------------------------------
# google-cloud-sdk - Dotfiles.
#
# Copyright (c) 2000-2020 by John Yancey, All rights reserved.
#
# August 2020 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------

# The next line updates PATH for the Google Cloud SDK.
if [ -f '${HOME}/lib/google-cloud-sdk/path.bash.inc' ]; then
    source '${HOME}/lib/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f '${HOME}/lib/google-cloud-sdk/completion.bash.inc' ]; then
    source '${HOME}/lib/google-cloud-sdk/completion.bash.inc'
fi
