---
id: adding-dependencies
title: Adding Dependencies
---

Lua has a very little standard library, so let's download some dependencies to get started.
Since we want to develop a CLI, we need a library capable of parsing flags and arguments.
To do so, we will use [`argparse`](https://luarocks.org/modules/argparse/argparse). We'll install it with the following command:
```sh
lx add argparse@0.7
```

:::note
This may take a while depending on your internet connection!
:::

The `@0.7` means we're targeting a specific version of `argparse`.
If you hadn't provided a version, the latest version would have been chosen.

## Testing Our Changes

To check whether `argparse` is loaded we can enter a Lua REPL and play around
with our code. However, just running `lua` will *not* load our dependenices. To enter a
`lua` REPL with our dependencies loaded, we need to run the following command:

```sh
lx lua
```

This acts as a direct wrapper around the `lua` program.
Once in the REPL, let's try to require our `argparse` code. Type `require("argparse").version`
and press enter. Below is the successful output:

```sh title="lx lua"
Lua 5.4.7  Copyright (C) 1994-2024 Lua.org, PUC-Rio
> require("argparse").version
0.7.1
>
```

Congratulations! We're now ready to start writing code in the next chapter.
You can exit the REPL by pressing `Ctrl+D` or typing `os.exit()` and pressing enter.
