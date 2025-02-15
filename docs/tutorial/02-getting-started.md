---
id: getting-started
title: Installation
sidebar_label: Getting Started
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

Due to the fact that we have no stable release yet, you must install the project
through `cargo`:

```sh
cargo install lux --locked
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

Ensure that installation was successful by running `lux help`.
You should see output similar to the following:
```
A fast and efficient Lua package manager

Usage: lux [OPTIONS] <COMMAND>

...
```

If you do, you're now ready to move on to the next section!
