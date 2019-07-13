# Dotfiles #

This repository containes my personal dot files, these files would only really work for someone like, well, me.

There are lot's of assumptions about where directories are located, and how development environments are consctructed. These dot files have lasted through four different conpanies, and works for my personal laptop and desktop, so can't be all that bad.

## Getting The Basics ##

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
 * findutils
 * fortune
 * iTerm2
 * macportsscripts
 * osxutils
 * tree

Accept all the additional dependent packages that are pulled in from these basic ports by using `port -N install ${package}`.

## Setting Up the Dotfiles ##

Now comes the easy part, assuming you've checked out this repository in to `$HOME/.files`, run the `$HOME/.files/setup.sh` script that exists in your new `.files` directory. This will create all the dot files in your `$HOME` directory, but as symbolic links to the source files in your `.files` directory.

### License ###

Apache License Version 2.0, January 2004
http://www.apache.org/licenses/