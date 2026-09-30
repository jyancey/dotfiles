#! /bin/bash
#------------------------------------------------------------------------------
# alias.sh - Dotfiles.
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
# Copyright (c) 2000-2020 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.w.yancey@gmail.com>
#
# $Id$
#------------------------------------------------------------------------------
#
if [[ "${DEBUG}" ]]; then
  echo "-------> setting up alias"
fi

# Set up some simple to use aliases for things.
#
if [[ "${OS_SYS}" == "Linux" ]]; then
    alias ls='ls --color=auto'
    alias vi='vim'
fi
if [[ "${OS_SYS}" == "SunOS" ]]; then
    if [[ "$OS_REL" == "5.11" ]]; then
        if [[ -x /usr/gnu/bin/ls ]]; then
            alias ls='/usr/gnu/bin/ls --color=auto'
        elif [[ -x /jds/cbe/bin/ls ]]; then
            alias ls='/jds/cbe/bin/ls --color=auto'
        fi
    fi
fi
if [[ "${OS_SYS}" == "Darwin" ]]; then
    if [[ -x /opt/homebrew/bin/lsd ]]; then
        alias ls='/opt/homebrew/bin/lsd'
    elif [[ -x /usr/local/bin/gls ]]; then
        alias ls='/usr/local/bin/gls --color=auto'
    else
        alias ls='ls -G'
        declare -x LSCOLORS=exgxDxDxcxDxDxhbcxheex
    fi
    if [[ -x /usr/local/bin/svn ]]; then
        alias svn=/usr/local/bin/svn
    fi
fi
if [[ "${OS_SYS}" == "FreeBSD" || "${OS_SYS}" == "OpenBSD" ]]; then
    if [[ -x /usr/local/bin/lsd ]]; then
        alias ls='/usr/local/bin/lsd'
    elif [[ -x /usr/local/bin/gls ]]; then
        alias ls='/usr/local/bin/gls --color=auto'
    else
        alias ls='ls -G'
    fi
fi
if [[ -f /usr/local/bin/git-svn ]]; then
    alias git-svn='/usr/local/bin/git-svn ${1:+"$@"}'
fi
if [[ -f /usr/ucb/ps ]]; then
    alias bsdps=/usr/ucb/ps
fi
alias ...='cd ../..'
alias ..='cd ..'
alias cls=clear 2>/dev/null
alias gr='egrep -i ${1:+"$@"}' 2>/dev/null
alias h='fc -l' 2>/dev/null
alias j='jobs -l' 2>/dev/null
alias l.='ls -dh .*' 2>/dev/null
alias l='ls -F' 2>/dev/null
alias lf='ls -lFAh' 2>/dev/null
alias ll='ls -lFh' 2>/dev/null
alias lt='ls --tree' 2>/dev/null
alias rrm='rm -fr ${1:+"$@"}'
alias sed='gsed'
alias wdiff='diff -bituNr ${1:+"$@"}'

#
# Java, and Java tools
#
alias java16=/Library/Java/JavaVirtualMachines/1.6.0_41-b02-445.jdk/Contents/Home/bin/java
alias java17=/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/bin/java
alias java18=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/bin/java
alias mvn='mvn4'
alias mc='mvn clean'
alias mcd='mvn clean deploy'
alias mci='mvn clean install'
alias mcp='mvn clean package'
alias mep='mvn help:effective-pom'
alias mp='mvn package'
#
# Golang
#
alias gob='go build'
alias goc='go clean'
alias god='go doc'
alias gof='go fmt'
alias gofa='go fmt ./...'
alias gog='go get'
alias goi='go install'
alias gol='go list'
alias gom='go mod'
alias gop='cd $GOPATH'
alias gopb='cd $GOPATH/bin'
alias gops='cd $GOPATH/src'
alias gor='go run'
alias got='go test'
alias gov='go vet'
#
# Git
#
alias gtb='git branch'
alias gtba='git branch -a'
alias gtc='git commit -v'
alias gtca='git commit -v -a'
alias gtd='git diff | $EDITOR'
alias gthst='history | gr ${1:+"$@"}' 2>/dev/null
alias gtpl='git pull'
alias gtlogs='git log --graph --full-history --all --color --pretty=tformat:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s%x20%x1b[33m(%an)%x1b[0m"'
alias gtlog='git log --oneline --decorate --color --pretty=tformat:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s%x20%x1b[33m(%an)%x1b[0m"'
alias gtph='git push'
alias gtsvn='git svn ${1:+"$@"}'
alias gtst='git status -s'
#
# Lock the screen
#
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
#
# Different Environment setups
#
alias jdsenv='. $HOME/.config/dotfiles/build_env/jdsenv.sh'
alias gnustep='. $HOME/.config/dotfiles/build_env/gnustep.sh'
