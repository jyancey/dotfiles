# Dotfiles

This repository contains my personal dotfiles, which are intended to work primarily for someone like me.

There are numerous assumptions about where directories are located and how development environments are set up. These dot files have lasted for twenty years, through four different companies, and work for my personal laptop and desktop, so they can't be all that bad.

A few things to remember: the default shell for macOS is zsh now, not bash, but these dot files have been developed to work with both shells. But if you see a bunch of errors, maybe temporarily turn off POSIX with `declare -x POSIXLY_CORRECT=0` or comment it out. However, you should leave it enabled, as it helps with things getting things working in both shells.

## macOS Basics

I use [HomeBrew](https://brew.sh), and build the package from source to locate the installed packages in the `/opt/homebrew` directory. Back in the good old days, this is where one would find all the "extra" tooling that the systems administrator had installed, because the standard OS install lacked valuable items like a compiler (you had to pay extra for the developer tool kits).

This is unsupported for [HomeBrew](https://brew.sh), note the build from source, but I like `/opt/homebrew` to look like what you'd see in the system `/usr` directory. Why? Well, if you are used to developing where `*.h` files are in `/usr/include`, you then expect that they would also exist in `/opt/homebrew/include`, see nice.

Also, [HomeBrew](https://brew.sh) has moved the installation location around, which was mainly driven by the x86 to arm64 swaps, and I’d have to “touch up” my installation all the time for the standard package install. One big downside is that with any major OS upgrade, you have to do this all over, since you can’t use the `brew migrate` command.

### HomeBrew Source Installation

Download the source packages from the [HomeBrew](https://brew.sh) website. Once the [HomeBrew](https://brew.sh) package manager is installed, you'll need to add the following ports as a minimum:

- coreutils
- cowsay
- diffutils
- figlet
- findutils
- fortune
- homebrewscripts
- osxutils
- tree

Accept all the additional dependent packages that are pulled in from these basic ports by using `brew install ${package}`.

There are a few optional packages that make things pleasant. You should `brew install oh-my-posh` to make your prompt all nice; this setup is skipped if `oh-my-posh` is not installed. Additionally, you might want to add `brew install lsd` and install some [Powerline Nerd fonts](https://www.nerdfonts.com) to complete the terminal set-up. Additionally, download [iTerm2](https://iterm2.com/downloads.html), but note that this setup also works with the built-in Terminal application on macOS.

## FreeBSD Basics

When installing these dotfiles on FreeBSD, you’ll have to do a little groundwork first. FreeBSD doesn’t ship with zsh as a system shell, so that needs to be installed first. Luckily, this is pretty easy.

1. `$ sudo pkg install zsh`
2. Then change your login shell to zsh, which should be `/usr/local/bin/zsh` with `chsh`.

There is also a minimum set of packages that must be installed first:

- bash
- coreutils
- cowsay
- diffutils
- figlet
- findutils
- tree

It's important to keep the system updated. Read over the [FreeBSD Handbook](https://docs.freebsd.org/en/books/handbook/cutting-edge/) on updating and upgrading a live system.

## GNU/Linux Basics

I've mostly stopped using GNU/Linux distributions, partly because there is no single standard for system shells or package-management tools. The landscape has also moved beyond familiar tools such as `rpm` and `apt-get` to include options such as Flatpak.

In general, the default shell configuration files provided by distributions should work. I have less opportunity to validate these dotfiles on GNU/Linux than on macOS and FreeBSD.

## Setting Up the Dotfiles

After cloning this repository to `$HOME/.config/dotfiles`, run `zsh install.sh` to check and install the platform dependencies and create the symlinks. To create symlinks only, run `zsh setup.sh`. Both commands preserve existing regular files; Bash startup files `.bash_profile` and `.bashrc`, Zsh's `.zshrc`, and `.profile` point to the shared `shellrc`.

```console
$ zsh setup.sh
Setting up symlinks in /Users/john if needed...
 linking .bashrc           => /Users/john/.config/dotfiles/shellrc
 linking .bash_profile     => /Users/john/.config/dotfiles/shellrc
 linking .bash_logout      => /Users/john/.config/dotfiles/bash_logout
 linking .dir_colors       => /Users/john/.config/dotfiles/dir_colors
 linking .hgignore_global  => /Users/john/.config/dotfiles/hgignore_global
 linking .indent.pro       => /Users/john/.config/dotfiles/indent.pro
 linking .gitconfig        => /Users/john/.config/dotfiles/gitconfig
 linking .gitignore_global => /Users/john/.config/dotfiles/gitignore_global
 linking .npmrc            => /Users/john/.config/dotfiles/npmrc
 linking .profile          => /Users/john/.config/dotfiles/shellrc
 linking .zshrc            => /Users/john/.config/dotfiles/shellrc
 linking .zprofile         => /Users/john/.config/dotfiles/zprofile
Done!
```

Both Bash login and interactive shells load `shellrc` directly through
`.bash_profile` and `.bashrc`, respectively. `.zprofile` remains separate;
Zsh login shells load the shared configuration through `.zshrc`.

The path configuration uses `$HOME/bin/path_helper` when available and falls
back to building `PATH` from the entries in `lib/paths` if it is not installed.

## License

Common Development and Distribution License 1.0  
SPDX short identifier: CDDL-1.0  
[CDDL-1.0](https://opensource.org/license/cddl-1-0/)
