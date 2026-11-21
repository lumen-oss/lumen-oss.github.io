---
id: data-files
title: How to access data files from a package
---

Packages sometimes ship non-Lua files, such as templates, JSON or icons. Lux
installs them under the rock's `etc` tree.
[`datafile`](https://github.com/hishamhm/datafile) locates them at runtime and
works with both Lux and Luarocks..

## Prerequisites

- A `datafile` release with Lux support.
- `lux-lua`, provided by `lx run` and `lx lua`.

## Add datafile as a dependency

Declare it in your `lux.toml`:

```toml
[dependencies]
datafile = ">= 0.12"
```

## Install the files under `etc`

Declare the directories to ship under `[build]` in your `lux.toml`:

```toml
[build]
copy_directories = ["assets"]
```

`assets/` is installed to `<rock>/etc/assets/`.

## Open a data file

```lua
local datafile = require("datafile")
local fd, err = datafile.open("assets/template.txt")
if not fd then
   error(err)
end
local template = fd:read("*a")
fd:close()
```

`datafile.open` searches the `etc` directory of the package that owns the
calling module. Paths are relative to `etc`, so `copy_directories = ["assets"]`
is found as `datafile.open("assets/template.txt")`.

## Use it with Luarocks.

The same code works with Luarocks.. Its opener searches the LuaRocks install
tree instead, so no extra step is needed.
