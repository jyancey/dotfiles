#! /bin/bash
#------------------------------------------------------------------------------
# aws.sh - Dotfiles.
#
# Copyright (c) 2000-2018 by John Yancey, All rights reserved.
#
# August 2013 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
if [ -d "${HOME}/.ec2" ]; then
  EC2_HOME=${HOME}/.ec2
  source ${EC2_HOME}/env.sh
fi
