#! /bin/bash
#------------------------------------------------------------------------------
# java.sh - Dotfiles.
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
# Copyright (c) 2000-2026 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.w.yancey@gmail.com>
#
# $Id$
#------------------------------------------------------------------------------
#
if [ "$DEBUG" ]; then
  echo "-------> setting up java"
fi

# Let's export the JAVA_HOME once we find it.
#
# Linux is a bit odd and it depends on which distrabution you run.
if [[ "${OS_SYS}" == "Linux" ]]; then
    if [[ "$OS_DIST" =~ "Fedora" ]]; then
        if [ -f "/usr/bin/java" ]; then
            JAVA_HOME=/usr
        elif [ -f "/usr/lib/jvm/jre-1.6.0/bin/java" ]; then
            JAVA_HOME=/usr/lib/jvm/jre-1.6.0
        elif [ -f "/usr/lib/jvm/jre-1.5.0/bin/java" ]; then
            JAVA_HOME=/usr/lib/jvm/jre-1.5.0
        fi
    fi
    if [[ "$OS_DIST" =~ "Ubuntu" ]]; then
       if [ -f "/usr/bin/java" ]; then
            JAVA_HOME=/usr
       elif [ -f "/usr/lib/jvm/java-6-sun/bin/java" ]; then
           JAVA_HOME=/usr/lib/jvm/java-6-sun
       elif [ -f "/usr/lib/jvm/java-6-openjdk/bini/java" ]; then
           JAVA_HOME=/usr/lib/jvm/java-6-openjdk
       fi
    fi
fi

if [[ "$OS_SYS" == "Darwin" ]]; then
    if [[ -z "${JAVA_HOME:-}" ]]; then
        if [ -x "/usr/libexec/java_home" ]; then
            JAVA_HOME=$(/usr/libexec/java_home)
        fi
        if [[ -z "${JAVA_HOME:-}" ]] &&
           [ -d "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home" ]; then
            JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
        fi
    fi
    if [ "${DEBUG}" ]; then
        echo "${JAVA_HOME}"
    fi
fi

# FreeBSD can have Sun Java, or the Diablo version
if [[ "$OS_SYS" == "FreeBSD" ]]; then
    if [ -f "/usr/local/bin/java" ]; then
        export JAVA_HOME=/usr/local
    elif [ -f "/usr/local/jdk1.5.0/bin/java" ]; then
        export JAVA_HOME=/usr/local/jdk1.5.0
    elif [ -f "/usr/local/diablo-jdk1.5.0/bin/java" ]; then
        export JAVA_HOME=/usr/local/diablo-jdk1.5.0
    fi
fi

# Let's define a few other Java type things.
# Maven build system
if [ -d "/opt/homebrew/bin/maven3" ]; then
    MAVEN_HOME=/opt/homebrew/bin/maven3
fi
# Groovy: Java scripting language.
if [ -d "/opt/homebrew/bin/groovy" ]; then
    GROOVY_HOME=/opt/homebrew/bin/groovy
fi
# Griffon the groovy base desktop application framework.
if [ -d "/opt/homebrew/bin/griffon" ]; then
    GRIFFON_HOME=/opt/homebrew/bin/griffon
fi
# Gradle is the build system based on Groovy.
if [ -d "/opt/homebrew/bin/gradle" ]; then
    GRADLE_HOME=/opt/homebrew/bin/gradle
fi
# Grails is like Rails, but on Groovy
if [ -d "/opt/homebrew/bin/grails" ]; then
    GRAILS_HOME=/opt/homebrew/bin/grails
fi

if [ -d "/opt/homebrew/bin/gant" ]; then
	GANT_HOME=/opt/homebrew/bin/gant
fi

declare -x JAVA_HOME
declare -x MAVEN_HOME
declare -x MAVEN_OPTS='-Xmx4096m -Xms2048m'
declare -x GROOVY_HOME
declare -x GRIFFON_HOME
declare -x GRADLE_HOME
declare -x GRAILS_HOME
declare -x GANT_HOME
