---
id: rockspec
title: How to use Lux with a rockspec file
---

This guide shows you how to use an existing LuaRocks rockspec with Lux.

:::note
Use this guide if you have an existing rockspec and prefer not to migrate to TOML.
For new projects, the TOML format is recommended.
:::

## Create a project

```sh
lx new .
```

## Add the rockspec

Place your rockspec in the project root as `extra.rockspec`:

```lua title="extra.rockspec"
package = "say"
version = "0.1.0-1"

source = {
  url = "git+https://github.com/my/project",
}

build = {
  type = "builtin",
  modules = {
    say = "src/my-project/init.lua"
  }
}
```

:::info
See the [rockspec format reference](https://github.com/luarocks/luarocks/blob/main/docs/rockspec_format.md).
:::

## Behaviour

Lux prioritizes rockspec data over TOML. If both files define the same field (e.g. `version` or `source`), the rockspec value is used and the TOML value is ignored.

## Clean up

Remove fields from `extra.rockspec` that your TOML already covers. You can omit fields that would normally be required — Lux falls back to the TOML for anything not in the rockspec.

Example of a rockspec that only overrides the build table:

```lua title="extra.rockspec"
build = {
  type = "builtin",
  modules = {
    say = "src/my-project/init.lua"
  }
}
```
