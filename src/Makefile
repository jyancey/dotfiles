#
#------------------------------------------------------------------------------
# Makefile - Makefile for builing my_path_helper
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
# Copyright (c) 2023 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.w.yancey@gmail.org>
#
# $Id$
#------------------------------------------------------------------------------
#

# Define the source files.
SRCFLS = my_path_helper.c

# Define the object files.
OBJFLS = my_path_helper.o

# Define the executable.
TGT    = my_path_helper

# Define the compile and link options.
CC     = cc
LL     = cc
CFLAGS = -O2 -g3 -std=c17 -Wall -Wextra -pedantic -D_FORTIFY_SOURCE=2 -fpic
LFLAGS =
PREFIX = /Users/john/bin

# Define the rules.
$(TGT): $(OBJFLS)
	$(LL) $(LFLAGS) -o $@ $(OBJFLS) $(LIBDRS) $(LIBFLS)

.c.o:
	$(CC) $(CFLAGS) -o $@ -c $(INCDRS) $<

all:
	make $(TGT)

install: $(TGT)
	install -v -m 755 -o john -g staff $(TGT) $(PREFIX)

clean:
	-rm $(TGT)
	-rm $(OBJFLS)
