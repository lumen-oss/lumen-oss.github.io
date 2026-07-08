---
id: neovim
title: How to use Neovim with Lux
---

This guide shows you how to use Neovim as the Lua interpreter for Lux projects.

## Lua version

Neovim ships with LuaJIT (equivalent to Lua 5.1). Set this in your `lux.toml`:

```toml title="lux.toml"
package = "package-name"
version = "0.1.0"
# highlight-next-line
lua = "==5.1"

...
```

## Customizing `run`

Set the `[run]` section to use `nvim -l`:

```diff title="lux.toml"
[run]
-args = [ "src/main.lua" ]
+command = "nvim"
+args = [ "-l", "src/main.lua" ]
```

## Running the project

Run the project with Neovim:

```sh
lx run
```
