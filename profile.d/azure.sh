#! /bin/bash
#------------------------------------------------------------------------------
# azure-cli - Dotfiles.
#
# Copyright (c) 2000-2020 by John Yancey, All rights reserved.
#
# August 2020 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------

if [ -f '${HOME}/lib/azure-cli/az.completion' ]; then
    source '${HOME}/lib/azure-cli/az.completion'
fi