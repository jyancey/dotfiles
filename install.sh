#! /usr/bin/env zsh
#
# Quick and dirty install script for personal dots files, and all the needed
# things to make it go.
#

function find_homebrew(){
  printf "One second while I check things out...\n"
  if [[ -x /usr/local/bin/brew ]]; then
    printf " Install prefix '/usr/local' exists.\t\t[OK]\n"
    PREFIX=/usr/local
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    printf " Install prefix '/opt/homebrew' exists.\t\t[OK]\n"
    PREFIX=/opt/homebrew
  else
    printf " Missing the 'brew' command.\t[FAIL]\n"
    return 1
  fi

  local BHOME=$PREFIX/bin/brew
  if [[ -x ${BHOME} ]]; then
    printf " HomeBrew installation exists.\t\t\t[OK]\n"
    declare -x HBHOME=$PREFIX
  else
    printf " HomeBrew installation missing.\t\t\t[FAIL]\n"
    exit
  fi
}

# Let's check to make sure everything is installed and we are ready to go. This
# assumes that the HomeBrew system has been installed and the base packages
# listed in '${pour_base[@]}' have also been installed.
function do_pour_check(){
  printf "Hang on, checking installed pours...\n"
  pour_base=(
    coreutils \
    cowsay \
    diffutils \
    figlet \
    findutils \
    fortune \
    osxutils \
    tree \
    zsh
  )
  for pour in "${pour_base[@]}"; do
    if [[ `$HBHOME/bin/brew list ${pour}` ]]; then
      printf " HomeBrew pour %-15s installed.\t[OK]\n" "${pour}"
    else
      printf " HomeBrew pour %-15s missing.\t[FAIL]\n" "${pour}"
      $HBHOME/bin/brew install ${pour}
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
    zsh
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
  find_homebrew
  do_pour_check
elif [[ ${OS_SYS} == 'FreeBSD' ]]; then
  printf "This seems to be a FreeBSD system.\n"
  do_pkg_check
fi

printf "Installation check completed. Runing setup.\n"
${SHELL} ${HOME}/.config/dotfiles/setup.sh

