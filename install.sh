#! /bin/sh
#
# Quick and dirty install script for personal dots files, and all the needed
# things to make it go.
#

function find_macports() {
  printf "One second while I check things out...\n"
  if [[ ${OS_SYS} == 'Darwin' ]]; then
    if [[ -x /usr/local/bin/port ]]; then
      printf " Install prefix '/usr/local' exists.\t\t[OK]\n"
      PREFIX=/usr/local
    elif [[ -x /opt/macports/bin/port ]]; then
      printf " Install prefix '/opt/macports' exists.\t\t[OK]\n"
      PREFIX=/opt/macports
    else
      printf " Missing the 'port' command.\t[FAIL]\n"
      return 1
    fi

    local PHOME=$PREFIX/var/macports/sources/rsync.macports.org/macports/release/tarballs
    if [[ -x ${PHOME} ]]; then
      printf " MacPorts installation exists.\t\t\t[OK]\n"
      declare -x MPHOME=$PREFIX
    else
      printf " MacPorts installation missing.\t\t\t[FAIL]\n"
      exit
    fi
  fi
}

# Let's check to make sure everything is installed and we are ready to go. This
# assumes that the MacPort system has been installed in '/usr/local' and the
# base packages listed in '${pkg_base[@]}' have also been installed.
function do_pkg_check(){
  printf "Hang on, checking installed packages...\n"
  pkg_base=(
    coreutils \
    cowsay \
    diffutils \
    figlet \
    findutils \
    fortune \
    macportsscripts \
    osxutils \
    tree \
  )
  for pkg in "${pkg_base[@]}"; do
    if [[ `port installed | grep ${pkg}` ]]; then
      printf " MacPorts package %-15s installed.\t[OK]\n" "${pkg}"
    else
      printf " MacPorts package %-15s missing.\t[FAIL]\n" "${pkg}"
      exit
    fi
  done
}


find_macports
do_pkg_check
