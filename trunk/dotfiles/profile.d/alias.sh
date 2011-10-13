#! /bin/bash
#------------------------------------------------------------------------------
# alias.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Set up some simple to use aliases for things.
#
if [ "$OS_SYS" == "Linux" ]; then
    alias ls='ls --color=auto'
    alias vi='vim'
fi
if [ "$OS_SYS" == "SunOS" ]; then
    if [ "$OS_REL" == "5.11" ]; then
        if [ -x /usr/gnu/bin/ls ]; then
            alias ls='/usr/gnu/bin/ls --color=auto'
        elif [ -x /jds/cbe/bin/ls ]; then
            alias ls='/jds/cbe/bin/ls --color=auto'
        fi
    fi
fi
if [ "$OS_SYS" == "Darwin" ]; then
    if [ -x /sw/bin/gls ]; then
        alias ls='/sw/bin/gls --color=auto'
    else
        alias ls='ls -G'
    fi
    if [ -x /sw/bin/svn ]; then
        alias svn=/sw/bin/svn
    fi
fi
if [ "$OS_SYS" == "FreeBSD" ]; then
    if [ -x /usr/local/bin/gls ]; then
        alias ls='/usr/local/bin/gls --color=auto'
    else
        alias ls='ls -G'
    fi
fi
if [ -f /auto/surf-tp/tools/ant/apache-ant-1.7.1/bin/ant ]; then
    alias ant='/auto/surf-tp/tools/ant/apache-ant-1.7.1/bin/ant ${1:+"$@"}'
fi
if [ -f /auto/surf-tp/configs/iwe/tools/apache-maven-2.2.1/bin/mvn ]; then
    alias mvn='/auto/surf-tp/configs/iwe/tools/apache-maven-2.2.1/bin/mvn ${1:+"$@"}'
fi
if [ -f /usr/cisco/packages/git/current/libexec/git-core/git-svn ]; then
    alias git-svn='/usr/cisco/packages/git/current/libexec/git-core/git-svn ${1:+"$@"}'
fi
if [ -f /usr/local/bin/git-svn ]; then
    alias git-svn='/usr/local/bin/git-svn ${1:+"$@"}'
fi
if [ -f /usr/cisco/bin/vim ]; then
    alias vim=/usr/cisco/bin/vim
    alias vi=/usr/cisco/bin/vim
    alias edit=/usr/cisco/bin/vim
fi
if [ -f /opt/rational/clearcase/bin/cleartool ]; then
    alias ct=/opt/rational/clearcase/bin/cleartool
fi
if [ -f /usr/ucb/ps ]; then 
    alias bsdps=/usr/ucb/ps
fi
alias ...='cd ../..'
alias ..='cd ..'
alias cl=clear 2>/dev/null
alias cws='cd /ws/joyancey-sjc'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gd='git diff | mate'
alias ghst='history | gr ${1:+"$@"}' 2>/dev/null
alias gl='git pull'
alias gp='git push'
alias gr='egrep -i ${1:+"$@"}' 2>/dev/null
alias gsvn='git-svn ${1:+"$@"}'
alias gst='git status'
alias h='fc -l' 2>/dev/null
alias j='jobs -l' 2>/dev/null
alias java14=/System/Library/Frameworks/JavaVM.framework/Versions/1.4/Commands/java
alias java15=/System/Library/Frameworks/JavaVM.framework/Versions/1.5/Commands/java
alias java16=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Commands/java
alias l.='ls -dh .*' 2>/dev/null
alias l='ls -F' 2>/dev/null
alias lf='ls -lFAh' 2>/dev/null
alias ll='ls -lFh' 2>/dev/null
alias lls='ls -lR | $HOME/bin/fullpath.rb' 2>/dev/null
alias mc='mvn clean'
alias mcd='mvn clean deploy'
alias mci='mvn clean install'
alias mcp='mvn clean package'
alias mep='mvn help:effective-pom'
alias mp='mvn package'
alias rrm='rm -fr ${1:+"$@"}'
alias wdiff='diff -bituNr ${1:+"$@"}'
#
# Easy SSH shortcuts.
#
alias solaris='ssh john@192.168.1.15'
alias ubuntu='ssh john@192.168.1.16'
alias sjclnx='ssh joyancey@sjc-joyancey-lnx.cisco.com'
alias iwesbx='ssh joyancey@iwe-quadlite.cisco.com'
#
# Different Environment setups
#
alias iosenv='. $HOME/.files/build_env/iosenv.sh'
alias iosund='. $HOME/.files/build_env/iosund.sh'
alias novaenv='. $HOME/.files/build_env/novaenv.sh'
alias novaund='. $HOME/.files/build_env/novaund.sh'
alias novaadm='. $HOME/.files/build_env/novaadm.sh'
alias jdsenv='. $HOME/.files/build_env/jdsenv.sh'
alias iweenv='. $HOME/.files/build_env/iweenv.sh'
alias iweund='. $HOME/.files/build_env/iweund.sh'
alias gnustep='. $HOME/.files/build_env/gnustep.sh'
