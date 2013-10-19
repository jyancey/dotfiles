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
  EC2_HOME=${HOME}/.ec2
fi
if [ -f "${EC2_HOME}/creds/pk-EN6UVWSR6O6PDMCE7M35J3KRURITXQEM.pem" ]; then
  EC2_PRIVATE_KEY=${EC2_HOME}/creds/pk-EN6UVWSR6O6PDMCE7M35J3KRURITXQEM.pem
fi
if [ -f "${EC2_HOME}/creds/cert-EN6UVWSR6O6PDMCE7M35J3KRURITXQEM.pem" ]; then
  EC2_CERT=${EC2_HOME}/creds/cert-EN6UVWSR6O6PDMCE7M35J3KRURITXQEM.pem
fi
declare -x AWS_ACCESS_KEY=AKIAIQUB4WGAYATWU32Q
declare -x AWS_SECRET_KEY=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
declare -x EC2_HOME
declare -x EC2_PRIVATE_KEY
declare -x EC2_CERT