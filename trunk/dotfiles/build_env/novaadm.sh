#! /bin/bash
#------------------------------------------------------------------------------
# novaadm.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id: novaadm.sh,v 1.2 2009/11/26 00:06:35 john Exp $
#------------------------------------------------------------------------------
#
# Build environment setup to build Nova.
# Contact the Nova Build & Tools Team <nova-build@cisco.com>
#
if [ "${NOVA_ENV}" == "SET" ]; then
	echo "Nova ACME build environment already setup!"
	return
fi

echo "Setting up Nova ACME admin environment..."

NOVA_ENV="SET"

# Save the path!
NOVA_OLDPATH=${PATH}

# ACME items
ACME_DISABLE_COPYRIGHT=1
ACME_SOURCE_BASE="nova"
ACME_USE_SSH=1
ACME_VIEW_SERVER="nova-build1"
ACME_PROCESS_ADMIN=1
#ACME_PROCESS_DEBUG=1
ACME_ADMIN=1
ACME_EMPTY_LU_OK=1
ACME_COMP_LIST_DIR="/nfs/acmecore_rw/ws"

alias co_comp='co -l $ACME_COMP_LIST_DIR/nova.complist'
alias ci_comp='ci -u $ACME_COMP_LIST_DIR/nova.complist'
alias wsadm='cd /vws/vqt/joyancey/'

# Setting that are tooling related more than anything.
NOVAREL="0.1"

INTEL_LICENSE_FILE="/sw/licensed/intel/licenses/*.lic"
if [ "${PLATFORM}" == "x86_64" ]; then
   ICC_DIR=beta64
else
   ICC_DIR=beta
fi 
ICCPATH=/sw/licensed/intel/${ICC_DIR}/bin

# Add in the Nova path's
PATH=/nfs/nova/tools/latest/bin:${PATH}
PATH=${PATH}:${ICCPATH}

export NOVA_ENV PATH NOVA_OLDPATH NOVAREL INTEL_LICENSE_FILE
export ACME_VIEW_SERVER ACME_DISABLE_COPYRIGHT ACME_SOURCE_BASE ACME_USE_SSH
export ACME_PROCESS_ADMIN ACME_PROCESS_DEBUG ACME_EMPTY_LU_OK ACME_EMPTY_LU_OK 
export ACME_COMP_LIST_DIR ACME_ADMIN

#------------------------------------------------------------------------------
