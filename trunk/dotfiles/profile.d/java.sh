#! /bin/bash
#------------------------------------------------------------------------------
# java.sh - Dotfiles.
#
# Copyright (c) 2000-2009 by John Yancey, All rights reserved.
#
# August 2000 John Yancey <john.yancey@acm.org>
#
# $Id$
#------------------------------------------------------------------------------
#
# Let's export the JAVA_HOME once we find it.
#
# Linux is a bit odd and it depends on which distrabution you run.
if [ "${OS_SYS}" == "Linux" ]; then
    if [[ "$OS_DIST" =~ "Red Hat" || "$OS_DIST" =~ "CentOS" ]]; then
        if [[ "$OS_DIST" =~ "Red Hat" && 
              "$OS_DIST_NAME" =~ "RedHatEnterpriseAS" ]];then
            if [ -f /ws/ccbubld-sjc/hudson-sjc-slave/tools/JDK6_18/bin/java ]; then

                LANG=en_US.ISO-8859-1
                JAVA_HOME=/ws/ccbubld-sjc/hudson-sjc-slave/tools/JDK6_18
            fi
        elif [ -f "/usr/bin/java" ]; then
            JAVA_HOME=/usr
        elif [ -f "/usr/lib/jvm/jre-sun/bin/java" ]; then
            JAVA_HOME=/usr/lib/jvm/jre-sun
        elif [ -f "/usr/lib/jvm/jre/bin/java" ]; then
            JAVA_HOME=/usr/lib/jvm/jre
       fi
    fi
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
if [ "$OS_SYS" == "SunOS" ]; then
    if [ -f "/usr/java/bin/java" ]; then
        JAVA_HOME=/usr/java
    fi
fi
if [ "$OS_SYS" == "Darwin" ]; then
    if [ -d "/System/Library/Frameworks/JavaVM.framework/Home" ]; then
        JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
    fi
fi
# FreeBSD can have Sun Java, or the Diablo version
if [ "$OS_SYS" == "FreeBSD" ]; then
    if [ -f "/usr/local/bin/java" ]; then
        JAVA_HOME=/usr/local
    elif [ -f "/usr/local/jdk1.5.0/bin/java" ]; then
        JAVA_HOME=/usr/local/jdk1.5.0
    elif [ -f "/usr/local/diablo-jdk1.5.0/bin/java" ]; then
        JAVA_HOME=/usr/local/diablo-jdk1.5.0
    fi
fi

# Tomcat6 (typically under /usr/share/tomcat6) set CATALINA_HOME
#if [ -d "/usr/share/tomcat6" ]; then
#    CATALINA_HOME=/usr/share/tomcat6
#elif [ -d "/usr/appserv/tomcat6" ]; then
#    CATALINA_HOME=/usr/appserv/tomcat6
#fi

export JAVA_HOME
export MAVEN_OPTS='-Xmx1024m -Xms512m'
