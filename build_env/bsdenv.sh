#! /bin/bash
#------------------------------------------------------------------------------
# bsdenv.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Build environment setup to build the "ports" collection for Nova.
#
# Jan 2008 - John Yancey <joyancey@cisco.com>
# Contact the Nova Build & Tools Team <nova-build@cisco.com>
#
# Base SCM is pulled from http://nova-server1.cisco.com by running:
# hg clone http://nova-server1.cisco.com/dev-hg/nova-tools
#
echo "Setting up NovaBSD ports build environment..."

NOVAREL="1.0"
NOVADIR="/usr/nova/bsdtools/$NOVAREL"
PREFIX="$NOVADIR"
LOCALBASE="$PREFIX"
PKG_DBDIR="$NOVADIR/pkg"
PORT_DBDIR="$NOVADIR/ports"

PORTSREL="7.0.0"
BASESCM="/ws/joyancey/nova-tools/bsdtools"
PORTSDIR="$BASESCM/$PORTSREL/ports"
DISTDIR="$PORTSDIR/distfiles"
WRKDIRPREFIX="$BASESCM/$PORTSREL/build/$PLATFORM"

#
# Good to have this some other place then the /ws space. We can 
# pkg_add these files (this can grow very quickly).
#
PACKAGES="$BASESCM/bsdtools-$NOVAREL/packages/$PLATFORM"

#
# Crazy junk to get the ports to install with out root privs.
#
SU_CMD="/usr/bin/su $USER -c"
MTREE_FILE="$PORTSDIR/Templates/BSD.nova.dist"
NO_MTREE="yes"
BINOWN="$USER"
BINGRP="eng"

#
# Oddball items to make perl/python/autoconf/automake packages work
#
PERL_VERSION="5.8.8"
PERL_VER="$PERL_VERSION"
PERL_ARCH="mach"
PERL_LEVEL=500808
PERL_PORT="perl5.8"
PERL5="$PREFIX/bin/perl${PERL_VERSION}"
PERL="$PREFIX/bin/perl"
WITHOUT_USE_PERL="yes"

AUTOCONF_VERSION="2.61"
AUTOCONF_SUFFIX="2.61"
AUTOCONF="$PREFIX/bin/autoconf-${AUTOCONF_SUFFIX}"
LIBTOOL="$PREFIX/bin/libtool"

ACME_SOURCE_BASE="cles"
ACME_USE_SSH=1

LDCONFIG="$BASESCM/ldconfig-fake"
LD_LIBRARY_PATH=/usr/nova/lib:/lib:/usr/lib:/usr/X11R6/lib:/usr/local/lib

export PATH ACME_SOURCE_BASE ACME_USE_SSH PORTSREL PORTSDIR DISTDIR WRKDIRPREFIX
export NOVAREL NOVADIR PREFIX BASESCM PACKAGES PKG_DBDIR SU_CMD MTREE_FILE
export NO_MTREE BINOWN BINGRP PERL_VERSION PERL_VER PERL_ARCH PERL_LEVEL
export PERL_PORT PERL5 PERL AUTOCONF_VERSION AUTOCONF_SUFFIX AUTOCONF
export LIBTOOL WITHOUT_USE_PERL LOCALBASE PORT_DBDIR LD_LIBRARY_PATH LDCONFIG

#------------------------------------------------------------------------------
