---
id: getting-started
title: Installation
sidebar_label: Getting Started
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

## Packages

Lux includes the following packages and libraries:

- `lux-cli`: The main CLI for interacting with projects and installing Lua packages
  from the command line.

- `lux-lua`: The Lux Lua API, which provides:
  - `lux.loader` for resolving potentially conflicting dependencies on `require` at runtime.
  - A work-in-progress API for embedding Lux into Lua applications.
  We provide builds of `lux-lua` for Lua 5.1, 5.2, 5.3, 5.4 and Luajit.

- `lux-lib`: The Lux library for Rust. A dependency of `lux-cli` and `lux-lua`.

## Installing Lux With a Distribution's Package Manager

[![Packaging status](https://repology.org/badge/vertical-allrepos/lux-cli.svg)](https://repology.org/project/lux-cli/versions)

### Nix and NixOS

[![nixpkgs unstable package](https://repology.org/badge/version-for-repo/nix_unstable/lux-cli.svg)](https://search.nixos.org/packages?channel=unstable&show=lux-cli&from=0&size=50&sort=relevance&type=packages&query=lux-cli)

If you are using [Nix or NixOS](https://nixos.org/),
you can install [`lux-cli`](https://search.nixos.org/packages?channel=unstable&show=lux-cli&from=0&size=50&sort=relevance&type=packages&query=lux-cli)
and [`lux-lua` for various Lua versions](https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=lux-lua).
You may also need to configure [`pkg-config`](https://search.nixos.org/packages?channel=unstable&show=pkg-config&from=0&size=50&sort=relevance&type=packages&query=pkg-config)
so that it can find `lux-lua` and Lua.

If you would like to use the latest release, our [source repository](https://github.com/lumen-oss/lux)
also provides a Nix flake.

### Arch Linux

For the best experience, we recommend you install the
[`lux-cli`](https://archlinux.org/packages/extra/x86_64/lux-cli/) package:

```sh
pacman -S lux-cli
```

It comes bundled with shell completions, man pages and `lux-lua` for the default Lua version.
If you want to use `lux-lua` for a specific Lua version, e.g. Lua 5.1:

```sh
pacman -S lua51-lux
```

## Binary distributions

We provide pre-built binary distributions on our GitHub repository's [releases page](https://github.com/lumen-oss/lux/releases/latest).
These come bundled with shell completions, man pages and `lux-lua` for each supported Lua version.

### Linux

#### AppImage

1. Download the AppImage for your architecture:

- `lx_<version>_<arch>.AppImage`

2. Run `chmod u+x lx_<version>_<arch>.AppImage` to make it executable.

If you system does not have FUSE, you can [extract the AppImage](https://github.com/AppImage/AppImageKit/wiki/FUSE#type-2-appimage):

```
./lx_<version>_<arch>.AppImage --appimage-extract
./squashfs-root/usr/bin/lx
```

#### Debian-based distributions

Download and install the `.deb` package for your architecture:

- `lx_<version>_<arch>.deb`

#### Arch Linux

Download the `PKGBUILD` and `lx_<version>_86_64.tar.gz` and install using [`makepkg`](https://wiki.archlinux.org/title/Makepkg).

### macOS

1. Download the `lux-cli_<version>_<arch>.dmg` archive for your architecture.
2. Extract the `.app` bundle to your `Applications`.
3. Make sure the path containing the `lx` binary (`/Applications/lux-cli.app/Contents/MacOS`)
   is on your `PATH`.
   Or, create a `zsh` alias to the bundled `lx` binary.

:::note
As a young FOSS project, we do not notarize the macOS package,
so you may have to configure Gatekeeper to allow you to use it.
:::

### Windows

1. Download and run the installer:

- `lx_<version>_x64-setup.exe`
- or `lx_<version>_x64_en-US.msi`

:::note
As a young FOSS project, we do not sign the Windows package with a CA,
so you will be shown a "Windows protected your PC" warning when running the installer.
:::

2. Add the install directory to your `PATH`.

:::important
Make sure to [enable a x64 hosted MSVC toolset](https://learn.microsoft.com/en-us/cpp/build/how-to-enable-a-64-bit-visual-cpp-toolset-on-the-command-line?view=msvc-170)
when using Lux on the command line.
:::

## Installing The Latest Release Using Cargo

Due to the fact that we have no stable release yet, you must install the project
through `cargo` if you want the latest release and are not using the Nix flake.
We recommend installing through `cargo binstall` for fastest install times:

```sh
cargo binstall lux-cli --locked
```

If you don't have `cargo binstall` installed, you can install Lux normally with:

```sh
cargo install lux-cli --locked
```

:::important For new cargo users
Make sure that `~/.cargo/bin/` is part of your shell's `$PATH`!

<Tabs>
    <TabItem value="sh" value="bash / zsh">
    ```bash
    export PATH="$HOME/.cargo/bin:$PATH"
    ```
    </TabItem>
    <TabItem value="fish" value="fish">
    ```bash
    fish_add_path ~/.cargo/bin
    ```
    </TabItem>
    <TabItem value="powershell" value="powershell">
    ```powershell
    $env:Path = "$HOME\.cargo\bin;$env:Path"
    ```
    </TabItem>
</Tabs>
:::

## Checking Installation

Ensure that installation was successful by running `lx help`.
You should see output similar to the following:
```
A fast and efficient Lua package manager

Usage: lx [OPTIONS] <COMMAND>

...
```

If you do, you're now ready to move on to the next section!
