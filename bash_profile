#! /bin/bash
#------------------------------------------------------------------------------
# bash_profile - Dotfiles bash login profile file.
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
# Copyright (c) 2000-2023 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.w.yancey@gmail.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Uncomment to turn dotfile debug statments on.
#export DEBUG=1
#
if [ "$DEBUG" ]; then
  echo "Turning on debug"
fi

#declare -x POSIXLY_CORRECT=1

# Bail out early if we started up from an X session. This only seems to be a
# problem on Ubuntu systems. Go figure.
if [ "$GDMSESSION" ]; then
    exit
fi

# Running as a login shell! We have already picked up the path setting
# from /etc/profile, now get the global aliases and functions
if [ -f /etc/bashrc ]; then
  if [ "$DEBUG" ]; then
    echo "---> sourcing /etc/bashrc"
  fi
  source /etc/bashrc
fi

# Use bash_completion, if completion exists
if [ -f /usr/local/etc/bash_completion ]; then
  if [ "$DEBUG" ]; then
    echo "---> sourcing /usr/local/etc/bash_completion"
  fi
  source /usr/local/etc/bash_completion
fi

# Export out all the system information
declare -x OS_SYS=`uname -s`
declare -x OS_REL=`uname -r`
declare -x OS_PLATFORM=`uname -p`
declare -x OS_MACHINE=`uname -m`
if [ "$DEBUG" ]; then
  echo "---> setting system $OS_SYS"
  echo "---> setting release $OS_REL"
  echo "---> setting platform $OS_PLATFORM"
  echo "---> setting arch $OS_MACHINE"
fi

# Figure out which Linux distribution we are on
if [ $OS_SYS == "Linux" ]; then
    OS_DIST=`/usr/bin/lsb_release -d | sed -e 's/Description:.//'`
    OS_DIST_NAME=`/usr/bin/lsb_release -i | sed -e 's/Distributor ID:.//'`
    declare -x OS_DIST
    declare -x OS_DIST_NAME
fi
# Figure out which MacOSX distribution we are on
if [ $OS_SYS == "Darwin" ]; then
    OS_DIST=`/usr/bin/sw_vers -productVersion`
    OS_DIST_NAME=`/usr/bin/sw_vers -productName`
    declare -x OS_DIST
    declare -x OS_DIST_NAME
    if [ "$DEBUG" ]; then
      echo "---> setting dist $OS_DIST"
      echo "---> setting name $OS_DIST_NAME"
    fi
fi

declare -x EDITOR=vim
declare -x PAGER=less
declare -x LC_ALL=C
declare -x LC_CTYPE=C
declare -x LANG=en_US.ISO-8859-1

if [ "$PS1" ]; then
    if [ "x`tput kbs`" != "x" ]; then # We can't do this with "dumb" terminal
      stty erase `tput kbs`
    fi
    case $TERM in
      xterm*)
          PROMPT_COMMAND='echo -ne "\033]0;${LOGNAME}@${HOSTNAME}: ${PWD}\007"'
          if [ "$TERM" = "xterm-color" ]; then
              declare -x TERM=xterm
          fi
      ;;
      *)
      ;;
    esac
    if [ -x /usr/local/bin/oh-my-posh ]; then
        eval "$(oh-my-posh init bash)"
    elif [ -e $HOME/.files/bashrc_prompt ]; then
        source $HOME/.files/bashrc_prompt
        if [ "$DEBUG" ]; then
          echo "---> sourcing $HOME/.files/bashrc_prompt"
        fi
    else
        declare -x PS1="[\u@\h \W]\\$ "
    fi
fi

if [ -e "${HOME}/.iterm2_shell_integration.bash" ]; then
	source $HOME/.iterm2_shell_integration.bash
    if [ "$DEBUG" ]; then
      echo "---> sourcing $HOME/.iterm2_shell_integration.bash"
    fi
fi

# Start up key chain server
if [ ! -f $HOME/.nokeychain ]; then
  if [ "$DEBUG" ]; then
    echo "---> sourcing $HOME/.files/bashrc_keychain"
  fi
  source $HOME/.files/bashrc_keychain
fi

# Now for all the tricky stuff
for EXTRAS in $HOME/.files/profile.d/*.sh ; do
  if [ -r "$EXTRAS" ]; then
    if [ "$DEBUG" ]; then
      echo "---> sourcing $EXTRAS"
    fi
    source $EXTRAS
  fi
done

umask 022
