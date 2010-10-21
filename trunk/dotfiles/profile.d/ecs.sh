#! /bin/bash
#------------------------------------------------------------------------------
# ecs.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id: ecs.sh,v 1.3 2009/11/26 00:06:36 john Exp $
#------------------------------------------------------------------------------
#
# Add strange Engenieering Computer Systems stuff here
CVSROOT=:pserver:john@sjc-joyancey-8717:/var/cvs
CVSIGNORE=path-jump.lst
CVS_RSH=ssh
PRINTER=sjc24-03-c305-c
LPDEST=$PRINTER
MOZ_PRINTER_NAME=$PRINTER

export CVSROOT CVSIGNORE CVS_RSH PRINTER LPDEST MOZ_PRINTER_NAME
