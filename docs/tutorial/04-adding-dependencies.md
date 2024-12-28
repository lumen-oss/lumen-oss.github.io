---
id: adding-dependencies
title: Adding Dependencies
---

Lua has a very little standard library, so let's download some dependencies to get started.
Since we want to develop a CLI, we need a library capable of parsing flags and arguments.
To do so, we will use [`argparse`](https://luarocks.org/modules/argparse/argparse).

First, edit your `project.rockspec` and add the following:

```lua title="project.rockspec"
rockspec_format = "3.0"
package = "my-lua-project"
version = "0.1.0"

source = {
    url = "https://example.com/thing/thing",
}

description = {
    summary = "A sample project.",
    maintainer = "vhyrro",
    license = "MIT",
    labels = { "learning" },
}

dependencies = {
    "lua>=5.1",
    -- highlight-next-line
    "argparse ~> 0.7",
}

build = {
    type = "builtin",
}
```

The `~> 0.7` means "the latest version that starts with `0.7`". As of making this tutorial, this is version `0.7.1`.

Let's build our project, which will download the new dependency:

```sh
rocks build
```

:::note
This may take a while depending on your internet connection!
:::


To get a list of all current installed dependencies, we can run:

```sh
rocks list
```

Below is the expected output:

```sh title="rocks list"
argparse
└── 0.7.1-1
```

### Testing Our Changes

To enter a `lua` REPL, run the following command:

```sh
rocks lua
```

Once in the REPL, let's try to require our `argparse` code. Type `require("argparse").version`
and press enter. Below is the successful output:

```sh title="rocks lua"
Lua 5.4.7  Copyright (C) 1994-2024 Lua.org, PUC-Rio
> require("argparse").version
0.7.1
>
```

Congratulations! We're now ready to start writing code in the next chapter.
