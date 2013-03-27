#! /bin/bash
#------------------------------------------------------------------------------
# java.sh - Dotfiles.
#
# Copyright (c) 2000-2013 by John Yancey, All rights reserved.
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
            if [ -f /auto/ecp_hudson/tools/jdk/jdk1.6.0_18/bin/java ]; then
                LANG=en_US.ISO-8859-1
                JAVA_HOME=/auto/ecp_hudson/tools/jdk/jdk1.6.0_18/
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
    if [ -x "/usr/libexec/java_home" ]; then
        JAVA_HOME=`/usr/libexec/java_home`
    fi
    # JAVA_HOME not set, so we have to hunt for it.
    if [ ! -z "$JAVE_HOME" ]; then
        if [ "$OS_DIST" =~ "10.8" ]; then
            if [ -d "/Library/Java/JavaVirtualMachines/jdk1.8.0.jdk/Contents/Home" ]; then
                JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0_41-b02-445.jdk/Contents/Home
            fi
        elif [ "$OS_DIST" =~ "10.7" ]; then
            if [ -d "/Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home" ]; then
                JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_09.jdk/Contents/Home
            elif [ -d "/Library/Java/JavaVirtualMachines/1.6.0_41-b02-445.jdk/Contents/Home" ]; then
                JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0_41-b02-445.jdk/Contents/Home
            fi
        fi
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

# Let's define a few other Java type things.
# Maven build system
if [ -d "/sw/share/java/maven3" ]; then
    MAVEN_HOME=/sw/share/java/maven3
elif [ -d "/sw/share/java/maven2" ]; then
    MAVEN_HOME=/sw/share/java/maven2
fi
# Groovy: Java scripting language.
if [ -d "/sw/share/java/groovy" ]; then
    GROOVY_HOME=/sw/share/java/groovy
fi
# Griffon the groovy base desktop application framework.
if [ -d "/sw/share/java/griffon" ]; then
    GRIFFON_HOME=/sw/shre/java/griffon
fi
# Gradel is the build system based on groovy
if [ -d "/sw/share/java/gradle" ]; then
    GRADEL_HOME=/sw/share/java/gradle
fi
# Grails is like Rails, but on Groovy
if [ -d "/sw/share/java/grails" ]; then
    GRAILS_HOME=/sw/share/java/grails
fi
# Tomcat6
if [ -d "/sw/share/java/tomcat6" ]; then
    CATALINA_HOME=/sw/share/java/tomcat6
elif [ -d "/usr/share/tomcat6" ]; then
    CATALINA_HOME=/usr/share/tomcat6
elif [ -d "/usr/appserv/tomcat6" ]; then
    CATALINA_HOME=/usr/appserv/tomcat6
fi

declare -x JAVA_HOME
declare -x MAVEN_HOME
declare -x MAVEN_OPTS='-Xmx2048m -Xms1024m -XX:MaxPermSize=128m'
declare -x GROOVY_HOME
declare -x GRIFFON_HOME
declare -x GRADEL_HOME
declare -x GRAILS_HOME
declare -x CATALINA_HOME