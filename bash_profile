#! /bin/bash
#------------------------------------------------------------------------------
# bash_profile - Dotfiles bash login profile file.
#
# Copyright (c) 2000-2011 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
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
if [ -f /sw/etc/bash_completion ]; then
  if [ "$DEBUG" ]; then
    echo "---> sourcing /sw/etc/bash_completion"
  fi
  source /sw/etc/bash_completion
fi

# Start up key chain server
if [ ! -f $HOME/.nokeychain ]; then
  if [ "$DEBUG" ]; then
    echo "---> sourcing $HOME/.files/bashrc_keychain"
  fi
  source $HOME/.files/bashrc_keychain
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

# Setup the basices then bail ou if Windoze.
if [ $OS_SYS == "CYGWIN_NT-6.1-WOW64" ]; then
    eval "$(dircolors -b $HOME/.dir_colors)"
    if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
    fi
    source $HOME/.files/bashrc_prompt
    # Some shortcuts for different directory listings
    alias ls='ls -hF --color=tty'                 # classify files in colour
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
    alias ll='ls -l'                              # long list
    alias la='ls -A'                              # all but . and ..
    alias l='ls -CF'
    echo -ne "\e]2;$@\a\e]1;$@\a";
    declare -x PATH=$PATH:/usr/gnu/bin
    return
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
    # x86_64 Apple hardware often runs 32-bit kernels (see OHAI-63)
    x86_64=$(sysctl -n hw.optional.x86_64)
    if [ $x86_64 -eq 1 ]; then
        declare -x OS_PLATFORM="x86_64"
    else
        declare -x OS_PLATFORM="i386"
    fi
    declare -x OS_DIST
    declare -x OS_DIST_NAME
    if [ "$DEBUG" ]; then
      echo "---> re-setting platform $OS_PLATFORM"
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
    if [ -e $HOME/.files/bashrc_prompt ]; then
        source $HOME/.files/bashrc_prompt
        if [ "$DEBUG" ]; then
          echo "---> sourcing $HOME/.files/bashrc_prompt"
        fi
    else
        declare -x PS1="[\u@\h \W]\\$ "
    fi
fi

# Now for all the tricky stuff
for EXTRAS in $HOME/.files/profile.d/*.sh ; do
  if [ -r "$EXTRAS" ]; then
    source $EXTRAS
    if [ "$DEBUG" ]; then
      echo "---> sourcing $EXTRAS"
    fi
  fi
done

umask 022

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
