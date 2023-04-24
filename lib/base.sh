#! /usr/bin/bash
#

# mans: Search manpage given in agument '1' for term given in argument '2' (case insensitive)
function mans { man "$1" | grep -iC2 --color=always "$2" | less ; }

# quiet: Mute output of a command
function quiet {
  "$@" &> /dev/null &
}

# lsgrep: Search through directory contents with grep 
function lsgrep { ls | grep "$*" ; }

# banish-cookies: Redirect .adobe and .macromedia files to /dev/null
function banish-cookies {
  rm -r ~/.macromedia ~/.adobe
  ln -s /dev/null ~/.adobe
  ln -s /dev/null ~/.macromedia
}

# hsstats: Show the n most used commands. defaults to 10
function hstats {
  if [[ $# -lt 1 ]]; then
    NUM=10
  else
    NUM=${1}
  fi
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head -"$NUM"
}

# zipf: To create a ZIP archive of a folder
function zipf { zip -r "$1".zip "$1" ; }

# extract: Extract most know archives with one command
function extract {
  if [ -f "$1" ] ; then
    case "$1" in
    *.tar.bz2)   tar xjf "$1"     ;;
    *.tar.gz)    tar xzf "$1"     ;;
    *.bz2)       bunzip2 "$1"     ;;
    *.rar)       unrar e "$1"     ;;
    *.gz)        gunzip "$1"      ;;
    *.tar)       tar xf "$1"      ;;
    *.tbz2)      tar xjf "$1"     ;;
    *.tgz)       tar xzf "$1"     ;;
    *.zip)       unzip "$1"       ;;
    *.Z)         uncompress "$1"  ;;
    *.7z)        7z x "$1"        ;;
    *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# buf: Back up file with timestamp
function buf {
  local filename filetime
  filename=$1
  filetime=$(date +%Y%m%d_%H%M%S)
  cp -a "${filename}" "${filename}_${filetime}"
}

# del: Move files to hidden folder in tmp, that gets cleared on each reboot
function del {
  mkdir -p /tmp/.trash && mv "$@" /tmp/.trash;
}

# mkiso: Creates iso from current dir in the parent dir (unless defined)
function mkiso {
  if _omb_util_command_exists mkisofs; then
    if [ -z ${1+x} ]; then
      local isoname=${PWD##*/}
    else
      local isoname=$1
    fi

    if [ -z ${2+x} ]; then
      local destpath=../
    else
      local destpath=$2
    fi

    if [ -z ${3+x} ]; then
      local srcpath=${PWD}
    else
      local srcpath=$3
    fi

    if [ ! -f "${destpath}${isoname}.iso" ]; then
      echo "writing ${isoname}.iso to ${destpath} from ${srcpath}"
      mkisofs -V "${isoname}" -iso-level 3 -r -o "${destpath}${isoname}.iso" "${srcpath}"
    else
      echo "${destpath}${isoname}.iso already exists"
    fi
  else
    echo "mkisofs cmd does not exist, please install cdrtools"
  fi
}

# ff: Find file under the current directory
function ff { /usr/bin/find . -name "$@" ; }      

# ffs: Find file whose name starts with a given string
function ffs { /usr/bin/find . -name "$@"'*' ; }

# ffe: Find file whose name ends with a given string
function ffe { /usr/bin/find . -name '*'"$@" ; }

# bigfind: Find files in the give directory
function bigfind {
  if [[ $# -lt 1 ]]; then
    echo_warn "Usage: bigfind DIRECTORY"
    return
  fi
  du -a "$1" | sort -n -r | head -n 10
}

# findPid: find out the pid of a specified process
function findPid { lsof -t -c "$@" ; }

# my_ps: List processes owned by my user:
function my_ps { ps "$@" -u "$USER" -o pid,%cpu,%mem,start,time,bsdtime,command ; }

# ips: display all ip addresses for this host
function ips {
  if [ -x "/sbin/ifconfig" ]; then
    ifconfig | awk '/inet /{ print $2 }'
  else
    echo "You don't have ifconfig command installed!"
  fi
}

# myip: displays your ip address, as seen by the Internet
function myip {
  res=$(curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+')
  echo -e "Your public IP is: $res"
}

# ii: display useful host related informaton
function ii {
  echo -e "You are logged on $HOST"
  echo -e "Additionnal information:$NC " ; uname -a
  echo -e "Users logged on:$NC " ; w -h
  echo -e "Current date :$NC " ; date
  echo -e "Machine stats :$NC " ; uptime
  [[ "$OS_SYS" == Darwin* ]] && echo -e "Current network location :$NC " ; scselect
  echo -e "Public facing IP Address :$NC " ; myip
  [[ "$OS_SYS" == Darwin* ]] && echo -e "DNS Configuration:$NC " ; scutil --dns
  echo
}

# batch_chmod: Batch chmod for all files & sub-directories in the current one
function batch_chmod {
  echo -ne "Applying 0755 permission for all directories..."
  (find . -type d -print0 | xargs -0 chmod 0755) &
  spinner
  
  echo -ne "Applying 0644 permission for all files..."
  (find . -type f -print0 | xargs -0 chmod 0644) &
  spinner
}

# usage: disk usage per directory, in Mac OS X and Linux
function usage {
  if [ "$OS_SYS" = "Darwin" ]; then
    if [ -n "$1" ]; then
      du -hd 1 "$1"
    else
      du -hd 1
    fi
  elif [ "$OS_SYS" = "Linux" ]; then
    if [ -n "$1" ]; then
      du -h --max-depth=1 "$1"
    else
      du -h --max-depth=1
    fi
  fi
}
