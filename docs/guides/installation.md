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

## Installing from source with Cargo

Install with a Rust toolchain via Cargo:

Install through `cargo binstall` for fastest install times:

```sh
cargo binstall lux-cli --locked
```

If you don't have `cargo binstall` installed, install Lux normally with:

```sh
cargo install lux-cli --locked
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

## Verifying the installation

Run `lx help` to check that Lux installed correctly:

```
lx help
```
