---
id: getting-started
title: Installation
sidebar_label: Getting Started
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

In this chapter, we'll get Lux installed and verify that it works.
By the end, we'll have the `lx` command ready to use.

## Downloading Lux

We'll download a pre-built binary from the [releases page](https://github.com/lumen-oss/lux/releases/latest).
Pick your platform below and follow the steps.

<Tabs>
  <TabItem value="linux" label="Linux">

Download the AppImage for your architecture:

- **x86_64**: `lx_<version>_x86_64.AppImage`
- **aarch64**: `lx_<version>_aarch64.AppImage`

Make it executable and place it on your `PATH`:

```sh
chmod u+x lx_<version>_x86_64.AppImage
mv lx_<version>_x86_64.AppImage ~/.local/bin/lx
```

  </TabItem>
  <TabItem value="macos" label="macOS">

Download the `.dmg` for your architecture:

- **x86_64**: `lux-cli_<version>_x86_64.dmg`
- **aarch64**: `lux-cli_<version>_aarch64.dmg`

Extract the `.app` bundle to your `Applications` folder, then add the
binary to your `PATH`:

```sh
export PATH="/Applications/lux-cli.app/Contents/MacOS:$PATH"
```

  </TabItem>
  <TabItem value="windows" label="Windows">

Download the installer:

- `lx_<version>_x64-setup.exe`

Run the installer, then add the install directory to your `PATH`.

  </TabItem>
</Tabs>

:::tip
If you prefer to use your system's package manager, check the
[installation how-to guide](/guides/installation) for platform-specific
instructions.
:::

## Verifying it works

Let's check that everything is set up correctly:

```sh
lx help
```

You should see something like:

```
A fast and efficient Lua package manager

Usage: lx [OPTIONS] <COMMAND>

...
```

If you see the help output, Lux is ready. We'll use it in the next chapter
to scaffold our project.
