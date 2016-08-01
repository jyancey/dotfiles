#! /bin/bash
#------------------------------------------------------------------------------
# aws.sh - Dotfiles.
#
# Copyright (c) 2000-2013 by John Yancey, All rights reserved.
#
# August 2013 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
if [ -d "${HOME}/.ec2" ]; then
  EC2_HOME=${HOME}/.ec2/
  source ${ECS_HOME}/env.sh
fi
