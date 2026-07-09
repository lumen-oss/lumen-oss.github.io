---
id: installation
title: How to install Lux
sidebar_position: 2
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

This guide covers the various ways to install Lux on your system.

## Package managers

### Nix and NixOS

Install [`lux-cli`](https://search.nixos.org/packages?channel=unstable&show=lux-cli&from=0&size=50&sort=relevance&type=packages&query=lux-cli)
and [`lux-lua` for various Lua versions](https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=lux-lua).
You may also need to configure [`pkg-config`](https://search.nixos.org/packages?channel=unstable&show=pkg-config&from=0&size=50&sort=relevance&type=packages&query=pkg-config)
so that it can find `lux-lua` and Lua.

If you would like to use the latest release, the [source repository](https://github.com/lumen-oss/lux)
also provides a Nix flake.

### Arch Linux

Install the [`lux-cli`](https://archlinux.org/packages/extra/x86_64/lux-cli/) package:

```sh
pacman -S lux-cli
```

It comes bundled with shell completions, man pages and `lux-lua` for the default Lua version.
If you want to use `lux-lua` for a specific Lua version, e.g. Lua 5.1:

```sh
pacman -S lua51-lux
```

## Binary distributions

Pre-built binary distributions are available on the [releases page](https://github.com/lumen-oss/lux/releases/latest).
These come bundled with shell completions, man pages and `lux-lua` for each supported Lua version.

<Tabs>
<TabItem value="linux" label="Linux">

Download the AppImage for your architecture:

- `lx_<version>_x86_64.AppImage`
- `lx_<version>_aarch64.AppImage`

Make it executable:

```sh
chmod u+x lx_<version>_x86_64.AppImage
```

If your system does not have FUSE, you can extract it instead:

```
./lx_<version>_<arch>.AppImage --appimage-extract
./squashfs-root/usr/bin/lx
```

Debian-based distributions can also use the `.deb` package:

- `lx_<version>_<arch>.deb`

</TabItem>
<TabItem value="macos" label="macOS">

Download the `.dmg` for your architecture:

- `lux-cli_<version>_x86_64.dmg`
- `lux-cli_<version>_aarch64.dmg`

Extract the `.app` bundle to your `Applications` folder, then add the
binary to your `PATH`:

```sh
export PATH="/Applications/lux-cli.app/Contents/MacOS:$PATH"
```

:::note
The package is not notarized, so you may need to configure Gatekeeper to allow it.
:::

</TabItem>
<TabItem value="windows" label="Windows">

Download and run the installer:

- `lx_<version>_x64-setup.exe`
- or `lx_<version>_x64_en-US.msi`

After installing, add the install directory to your `PATH`.

:::note
The package is not signed, so Windows will show a "Windows protected your PC" warning.
:::

:::important
Enable a [x64 hosted MSVC toolset](https://learn.microsoft.com/en-us/cpp/build/how-to-enable-a-64-bit-visual-cpp-toolset-on-the-command-line?view=msvc-170)
when using Lux on the command line.
:::

</TabItem>
</Tabs>

## Building from source with Cargo

### Dependencies

Building Lux from source requires:

- A Rust toolchain (install via [rustup](https://rustup.rs/))
- `gnupg`, `libgpg-error` and `gpgme` (on Unix-like systems)
- If building without the `vendored` feature: `libgit2` and `openssl`
- If building with the `vendored` feature: `perl`, `perl-core`, and `make`

To link `gpgme` statically on Linux and macOS, set:

```sh
export SYSTEM_DEPS_LINK=static
```

### Install with Cargo

Install through `cargo binstall` for fastest install times:

```sh
cargo binstall lux-cli --locked
```

If you don't have `cargo binstall` installed, install Lux normally with:

```sh
cargo install lux-cli --locked
```

### Build with vendored dependencies

To statically link `libgit2` and `openssl`:

```sh
SYSTEM_DEPS_LINK=static cargo build --locked --profile release --features vendored
```

### Build without vendored dependencies

```sh
cargo build --locked --profile release
```

### Build on Windows (MSVC)

The `gpgme` feature must be disabled on Windows:

```sh
cargo build --locked --profile release --no-default-features --features vendored
```

:::important For new cargo users
Make sure that `~/.cargo/bin/` is part of your shell's `$PATH`!

<Tabs>
    <TabItem value="sh" label="bash / zsh">
    ```bash
    export PATH="$HOME/.cargo/bin:$PATH"
    ```
    </TabItem>
    <TabItem value="fish" label="fish">
    ```bash
    fish_add_path ~/.cargo/bin
    ```
    </TabItem>
    <TabItem value="powershell" label="powershell">
    ```powershell
    $env:Path = "$HOME\.cargo\bin;$env:Path"
    ```
</TabItem>
</Tabs>
:::

### For package maintainers

To build `lux-lua` for a specific Lua version:

```sh
cargo xtask51 dist-lua  # Lua 5.1
cargo xtask52 dist-lua  # Lua 5.2
cargo xtask53 dist-lua  # Lua 5.3
cargo xtask54 dist-lua  # Lua 5.4
cargo xtask55 dist-lua  # Lua 5.5
cargo xtaskjit dist-lua # LuaJIT
```

This installs `lux-lua` to `target/dist/share/lux-lua/<lua>/lux.so` and a
`pkg-config` `.pc` file to `target/dist/lib/lux-lua*.pc`.

To build shell completions:

```sh
cargo xtask dist-completions
```

To build man pages:

```sh
cargo xtask dist-man
```

To build the full binary distribution (bundled with completions, man pages,
and `lux-lua` for all supported Lua versions):

```sh
cargo xtask dist-package
```

## Verifying the installation

Run `lx help` to check that Lux installed correctly:

```
lx help
```
