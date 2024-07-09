# Dotfiles #

This repository containes my personal dot files, these files would only really work for someone like, well, me.

There are lot's of assumptions about where directories are located, and how development environments are consctructed. These dot files have lasted for 20 years, through four different conpanies, and works for my personal laptop and desktop, so can't be all that bad.

A few things to remember, the default shell for macOS is zsh now, not bash, but these dot files have been developed to work with both shells. But if you see a bunch of errors, maybe temporarily turn off POSIX with `declare -x POSIXLY_CORRECT=0` or comment it out. However, you should leave it enabled, it helps with things getting things working in both shells.

## The Basics ##

I personally use [MacPorts](https://www.macports.org), and build the package from source to locate the installed packages in the `/usr/local` directory. Back in the good old days, this is where one would find all the "extra" tooling that the SysAdmin had installed, becuase the normal OS install lacked usefull items like a compiler (you had to pay extra for the developer tool kits).

This is unsupported for [MacPorts](https://www.macports.org), note the build from source, but I like `/usr/local` to look like what you'd see in the system `/usr` directory. Why? Well, if you are used to developing where `*.h` files are in `/usr/include` you then expectat they would also exist in `/usr/local/include`, see nice.

### MacPorts Source Installation ###

Download the source packages from the [MacPorts Dowloads](https://www.macports.org/install.php) website, then:

1. `cd`into the directory where you've downloaded the source package and unpack the thing.
2. `./configure --prefix=/usr/local --with-unsupported-prefix && make && sudo make install`

Once the [MacPorts](https://www.macports.org) package manager is installed, you'll need to add the following ports as the minimum:

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

There are a few optional packages that make things nice, you should `port install oh-my-posh` to make your prompt all nice, this set-up is skipped if `oh-my-posh` in not installed. Additionall, you might want to add `port install lsd` and install some [Powerline Nerd fonts](https://www.nerdfonts.com) to complete the terminal set-up. Also go get [iTerm2](https://iterm2.com/downloads.html), but this all works with the out of the box Terminal application on macOS.

### Setting Up the Dotfiles ###

Now comes the easy part, assuming you've checked out this repository in to `$HOME/.config/dotfiles` with `git clone https://github.com/jyancey/dotfiles.git ~/.config/dotfiles` run the `$HOME/.config/dotfiles/setup.sh` script that exists in your new `~/.config/dotfiles` directory. This will create all the needed `.${files}` in your `$HOME` directory, but as symbolic links to the source files in your `~/.config/dotfiles` directory. The setup script runs a quick check to make sure you have the basics installed for things to work. You should see:

```
$ ~/.config/dotfiles/setup.sh
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

## License ##

Common Development and Distribution License 1.0<br />
SPDX short identifier: CDDL-1.0<br />
https://opensource.org/license/cddl-1-0/<br />
