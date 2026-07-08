---
id: adding-dependencies
title: Adding Dependencies
---

In this chapter, we'll add an argument parser called `argparse` to our project
and verify it loads correctly with `lx lua`.

Since we're building a CLI, we need something to parse flags and arguments.
We'll use version `0.7` of [`argparse`](https://luarocks.org/modules/argparse/argparse):

```sh
lx add argparse@0.7
```

Lux will download and install `argparse` and any transitive dependencies.
You should see output similar to:

```
Added argparse 0.7.1
...
```

:::note
This may take a while depending on your internet connection!
:::

## Testing Our Changes

To check whether `argparse` is loaded, we can enter a Lua REPL and play around
with our code. However, just running `lua` will not work. To enter a
`lua` REPL with our dependencies loaded, we need to run the following command instead:

```sh
lx lua
```

This acts as a direct wrapper around the regular `lua` program.
Once in the REPL, let's try to require our `argparse` code. Type `require("argparse").version`
and press enter. Below is the successful output:

```sh title="lx lua"
Lua 5.4.7  Copyright (C) 1994-2024 Lua.org, PUC-Rio
> require("argparse").version
0.7.1
>
```

We're now ready to start writing some serious code in the next chapter.
You can exit the REPL by pressing `Ctrl+D` or typing `os.exit()` and pressing enter.
