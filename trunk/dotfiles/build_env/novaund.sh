#! /bin/bash
#------------------------------------------------------------------------------
# novaund.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id: novaund.sh,v 1.2 2009/11/26 00:06:36 john Exp $
#------------------------------------------------------------------------------
#
# Build environment setup to build Nova.
# Contact the Nova Build & Tools Team <nova-build@cisco.com>
#
echo "Unsetting Nova ACME build environment..."

NOVA_ENV=0
PATH=${NOVA_OLDPATH}
unset NOVA_OLPATH

unset ACME_DISABLE_COPYRIGHT
unset ACME_SOURCE_BASE
unset ACME_USE_SSH
unset ACME_VIEW_SERVER
unset ACME_EMPTY_LU_OK
unset ACME_WORKSPACE_AUDIT_MODE
unset NOVAREL
unset INTEL_LICENSE_FILE
unset ICCPATH

export PATH NOVA_ENV

#------------------------------------------------------------------------------
