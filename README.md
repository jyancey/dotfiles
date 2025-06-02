# Dotfiles #

This repository contains my personal dotfiles, which are intended to work primarily for someone like me.

There are numerous assumptions about where directories are located and how development environments are set up. These dot files have lasted for twenty years, through four different companies, and work for my personal laptop and desktop, so they can't be all that bad.

A few things to remember: the default shell for macOS is zsh now, not bash, but these dot files have been developed to work with both shells. But if you see a bunch of errors, maybe temporarily turn off POSIX with `declare -x POSIXLY_CORRECT=0` or comment it out. However, you should leave it enabled, as it helps with things getting things working in both shells.

# macOS Basics #

I use [MacPorts](https://www.macports.org), and build the package from source to locate the installed packages in the `/opt/macports` directory. Back in the good old days, this is where one would find all the "extra" tooling that the systems administrator had installed, because the standard OS install lacked valuable items like a compiler (you had to pay extra for the developer tool kits).

This is unsupported for [MacPorts](https://www.macports.org), note the build from source, but I like `/opt/macports` to look like what you'd see in the system `/usr` directory. Why? Well, if you are used to developing where `*.h` files are in `/usr/include`, you then expect that they would also exist in `/opt/macports/include`, see nice.

Also, [MacPorts](https://www.macports.org) has moved the installation location around, which was mainly driven by the x86 to arm64 swaps, and I’d have to “touch up” my installation all the time for the standard package install. One big downside is that with any major OS upgrade, you have to do this all over, since you can’t use the `sudo port migrate` command. 

## MacPorts Source Installation ##

Download the source packages from the [MacPorts Downloads](https://www.macports.org/install.php) website, then:

1. `cd`into the directory where you've downloaded the source package and unpack it.
2. `./configure --prefix=/opt/macport --with-unsupported-prefix && make && sudo make install`

Once the [MacPorts](https://www.macports.org) package manager is installed, you'll need to add the following ports as a minimum:

 * coreutils
 * cowsay
 * diffutils
 * figlet
 * findutils
 * fortune
 * macportsscripts
 * osxutils
 * tree

Accept all the additional dependent packages that are pulled in from these basic ports by using `port -N install ${package}`.

There are a few optional packages that make things pleasant. You should `port install oh-my-posh` to make your prompt all nice; this setup is skipped if `oh-my-posh` is not installed. Additionally, you might want to add `port install lsd` and install some [Powerline Nerd fonts](https://www.nerdfonts.com) to complete the terminal set-up. Additionally, download [iTerm2](https://iterm2.com/downloads.html), but note that this setup also works with the built-in Terminal application on macOS.

# FreeBSD #

When installing these dotfiles on FreeBSD, you’ll have to do a little groundwork first. FreeBSD doesn’t ship with zsh as a system shell, so that needs to be installed first. Luckily, this is pretty easy.

`$ sudo pkg install zsh`

Then change your login shell to zsh, which should be `/usr/local/bin/zsh`.

`$ chsh`

There is also a minimum set of packages that must be installed first:

* bash
* coreutils
* cowsay
* diffutils
* figlet
* findutils
* tree

# Setting Up the Dotfiles #

Now comes the easy part, assuming you've checked out this repository in to `$HOME/.config/dotfiles` with `git clone https://github.com/jyancey/dotfiles.git ~/.config/dotfiles` run the `$HOME/.config/dotfiles/setup.sh` script that exists in your new `~/.config/dotfiles` directory. This will create all the needed `.${files}` in your `$HOME` directory, but as symbolic links to the source files in your `~/.config/dotfiles` directory. The setup script performs a quick check to ensure you have the necessary basics installed for everything to work correctly. You should see:

```
$ ~/.config/dotfiles/install.sh
One second while I test things out...
 Install prefix '/usr/local' exists.          [OK]
 MacPorts instalation exists.                 [OK]
 MacPorts port command exists.                [OK]
 MacPorts package coreutils       installed.  [OK]
 MacPorts package cowsay          installed.  [OK]
 MacPorts package diffutils       installed.  [OK]
 MacPorts package figlet          installed.  [OK]
 MacPorts package findutils       installed.  [OK]
 MacPorts package fortune         installed.  [OK]
 MacPorts package macportsscripts installed.  [OK]
 MacPorts package osxutils        installed.  [OK]
 MacPorts package tree            installed.  [OK]
 Setting up symlinks in /Users/john
 linking bashrc
 linking bash_logout
 linking dir_colors
 linking hgignore_global
 linking indent.pro
 linking gitconfig
 linking gitignore_global
 linking npmrc
 linking profile
 linking vimrc
 linking vim_runtime
 linking zprofile
 linking zshrc
 linking zsh_logout
Done!
 ```

Next is to compile and install the modified `path_helper` command that is in the `path_helper` repo on GitHub. A simple `make && make install && make clean` should do the trick.

# License #

Common Development and Distribution License 1.0<br />
SPDX short identifier: CDDL-1.0<br />
https://opensource.org/license/cddl-1-0/<br />
