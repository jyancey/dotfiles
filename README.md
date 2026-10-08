# Dotfiles

This repository contains my personal dotfiles, which are intended to work primarily for someone like me.

There are numerous assumptions about where directories are located and how development environments are set up. These dot files have lasted for twenty years, through four different companies, and work for my personal laptop and desktop, so they can't be all that bad.

A few things to remember: the default shell for macOS is zsh now, not bash, but these dotfiles are intended to work with both shells. The shared startup file sets `POSIXLY_CORRECT`; to temporarily test whether that setting is causing a problem, run `unset POSIXLY_CORRECT` in the current shell. Setting it to `0` does not disable it. The setting is restored in a new shell.

## macOS Basics

The macOS installer supports Homebrew at `/usr/local` or `/opt/homebrew`. Some profile modules also account for MacPorts at `/opt/macports`. The setup does not install Homebrew itself.

### macOS Dependencies

Run `zsh install.sh` to check for and install missing Homebrew packages. The installer checks for:

- coreutils
- cowsay
- diffutils
- figlet
- findutils
- fortune
- osxutils
- tree
- zsh

The `lsd` package is optional; when found in the configured locations it is used for the `ls` alias and tree listing. The prompt is configured by the repository's `prompt` file and does not require oh-my-posh. [iTerm2](https://iterm2.com/downloads.html) is also optional; the setup works with the built-in Terminal.

## FreeBSD Basics

When installing these dotfiles on FreeBSD, you’ll have to do a little groundwork first. FreeBSD doesn’t ship with zsh as a system shell, so that needs to be installed first. Luckily, this is pretty easy.

1. `$ sudo pkg install zsh`
2. Then change your login shell to zsh, which should be `/usr/local/bin/zsh` with `chsh`.

The `install.sh` helper checks for and installs these packages:

- bash
- coreutils
- cowsay
- diffutils
- figlet
- findutils
- tree
- zsh

It's important to keep the system updated. Read over the [FreeBSD Handbook](https://docs.freebsd.org/en/books/handbook/cutting-edge/) on updating and upgrading a live system.

## GNU/Linux Basics

I've mostly stopped using GNU/Linux distributions, partly because there is no single standard for system shells or package-management tools. The landscape has also moved beyond familiar tools such as `rpm` and `apt-get` to include options such as Flatpak.

In general, the default shell configuration files provided by distributions should work. I have less opportunity to validate these dotfiles on GNU/Linux than on macOS and FreeBSD.

## Setting Up the Dotfiles

Clone the repository to `$HOME/.config/dotfiles`, then run:

```sh
zsh install.sh
```

This checks or installs the platform dependencies supported by the helper, then runs `setup.sh`. To create or update symlinks without the dependency check, run `zsh setup.sh`. Existing regular files are preserved; existing symlinks at the managed paths are updated to their expected targets. Run `zsh setup.sh -r` to remove symlinks at those managed paths.

The setup links `.bash_profile`, `.bashrc`, `.profile`, and `.zshrc` to the shared `shellrc`. It links `.zprofile` to the repository's separate `zprofile` file; interactive Zsh login shells also read `.zshrc`, which loads the shared configuration.

The path configuration uses `$HOME/bin/path_helper` when available and falls
back to building `PATH` from existing directories listed in `lib/paths`.

## License

Common Development and Distribution License 1.0  
SPDX short identifier: CDDL-1.0  
[CDDL-1.0](https://opensource.org/license/cddl-1-0/)
