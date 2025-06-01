#! /bin/sh
#
# Quick and dirty install script for personal dots files, and all the needed
# things to make it go.
#

function find_macports(){
  printf "One second while I check things out...\n"
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
}

# Let's check to make sure everything is installed and we are ready to go. This
# assumes that the MacPort system has been installed and the base packages 
# listed in '${port_base[@]}' have also been installed.
function do_port_check(){
  printf "Hang on, checking installed ports...\n"
  port_base=(
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
  for port in "${port_base[@]}"; do
    if [[ `$MPHOME/bin/port installed | grep ${port}` ]]; then
      printf " MacPorts port %-15s installed.\t[OK]\n" "${port}"
    else
      printf " MacPorts port %-15s missing.\t[FAIL]\n" "${port}"
      sudo $MPHOME/bin/port install ${port}
    fi
  done
}

# This is a FreeBSD system, so no ports, but there are pkg's, so are the
# pkgs listed in '${pkg_base[@]}' been installed.
function do_pkg_check(){
  printf "Hang on, checking the installed pkgs...\n"
  pkg_base=(
    bash \
    coreutils \
    cowsay \
    diffutils \
    figlet \
    findutils \
    tree \
    zsh \
  )
  for pkg in "${pkg_base[@]}"; do
    if [[ `pkg info | grep ${pkg}` ]]; then
      printf " FreeBSD pkg %-15s installed.\t[OK]\n" "${pkg}"
    else
      printf " FreeBSD pkg %-15s missing.\t[FAIL]\n" "${pkg}"
      # Install missing 
      sudo /usr/local/sbin/pkg install ${pkg}
    fi
  done
}

if [[ ${OS_SYS} == 'Darwin' ]]; then
  printf "This seems to be a macOS system.\n"
  find_macports
  do_port_check
elif [[ ${OS_SYS} == 'FreeBSD' ]]; then
  printf "This seems to be a FreeBSD system.\n"
  do_pkg_check
fi

printf "Installation check completed. Runing setup.\n"
${SHELL} ${HOME}/.config/dotfiles/setup.sh

