# Copilot Instructions

## What This Repo Is

Personal dotfiles managed via symlinks. The repo lives at `~/.config/dotfiles` and `setup.sh` creates symlinks in `$HOME` pointing back into it. `.bash_profile`, `.bashrc`, `.zshrc`, and `.profile` symlink to the shared `shellrc`; `.zprofile` remains a separate login-shell file so Zsh does not run the shared interactive setup twice.

## Setup Commands

```bash
# Install dependencies + create symlinks
zsh install.sh

# Create symlinks only
zsh setup.sh

# Remove all symlinks
zsh setup.sh -r
```

There are no build, test, or lint commands — this is a configuration-only repo.

## Architecture

### Shell Initialization Flow

```
~/.bash_profile or ~/.bashrc or ~/.zshrc
  → shellrc (unified entry point)
      → /etc/${MYSHELL}rc (system defaults)
      → profile.d/*.sh (tool-specific modules, sourced in glob order)
      → prompt (custom shell prompt)
      → keychain (Zsh only; skipped if ~/.nokeychain exists)
```

### Directory Layout

- **`shellrc`** — Shared Bash/Zsh startup. Sets `$MYSHELL`, `$OS_SYS`, `$OS_DIST`, core env vars (`EDITOR`, `PAGER`, `LC_ALL`), and sources shell-compatible modules in `profile.d/`.
- **`profile.d/`** — One `.sh` file per tool/concern (e.g., `alias.sh`, `paths.sh`, `go.sh`, `java.sh`). Keep modules parseable in both shells or explicitly gate shell-specific syntax.
- **`lib/`** — Static data files: `paths`, `manpaths`, `infopaths` (one directory per line), and `base.sh` (shell utility functions).
- **`build_env/`** — Environment setup scripts for specific build contexts (sourced manually via aliases).
- **`oh-my-posh/`** — oh-my-posh theme files.

## Key Conventions

### File Headers
All shell scripts carry a CDDL 1.0 license header. Match this format when adding new files.

### Variable Declarations
Use `declare -x VAR=value` (not `export VAR=value`) for compatibility with `POSIXLY_CORRECT=1`, which is set at shell startup. Both forms appear in the codebase; prefer `declare -x` in `shellrc` and `profile.d/`.

### OS Detection
OS type is exported as `$OS_SYS` (`Darwin`, `FreeBSD`, `Linux`, `SunOS`). All platform-specific logic must gate on this variable:

```bash
if [[ "${OS_SYS}" == "Darwin" ]]; then
  # macOS-specific
fi
```

### Adding a New Tool Config
Create `profile.d/toolname.sh`. Follow the pattern in existing files:
1. Guard debug output with `[[ "${DEBUG}" ]] && echo "..."`
2. Gate tool-specific config on a binary existence check (`[[ -x /path/to/tool ]]`)
3. Export only what's needed downstream

### MacPorts vs. Homebrew
MacPorts is the preferred package manager on macOS. Prefix is `/opt/macports` (or `/usr/local` as fallback). Check for MacPorts binaries first, Homebrew second.

### `lsd` Preference
`alias.sh` sets `ls` to `lsd` when available, with fallback to `gls --color=auto`, then `ls -G`. Don't assume a specific `ls` binary.

### Keychain Suppression
To disable keychain at startup on a machine, create `~/.nokeychain`.

### Debug Mode
Set `DEBUG=1` before sourcing to trace every file being sourced:
```bash
DEBUG=1 zsh
```
