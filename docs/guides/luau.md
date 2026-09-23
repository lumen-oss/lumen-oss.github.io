---
id: luau
title: How to use Luau with Lux
---

This guide shows you how to create, run, and test a [Luau](https://luau.org) project with Lux.

## Declare the language

Set `lua = "luau"` in your `lux.toml`:

```toml title="lux.toml"
package = "my-luau-project"
lua = "luau"
```

## Install a runtime

Install the Luau runtime:

```sh
lx --lua-version luau install-lua
```

Lux uses a `luau` or `lune` binary from your `PATH` when available, and builds `luau`
from source otherwise. To prefer `lune` or a custom binary, set the `LUAU` variable:

```sh
lx --variables LUAU=lune --lua-version luau install-lua
```

## Run the project

Declare an entry point under `[run]`, then run it:

```toml title="lux.toml"
[run]
args = ["src/main.luau"]
```

```sh
lx run
```

Under Luau, Lux resolves dependencies through a generated `.luaurc` rather than `LUA_PATH`.
See [How Lux supports Luau](/explanations/luau-support) for the details.

## Test the project

`lx test` uses the [tiniest](https://github.com/dphfox/tiniest) framework by default for
Luau projects. Place `*.spec.luau` (or `*.spec.lua`) files under `test/` or `tests/`:

```lua title="tests/greeting.spec.luau"
return function(tiniest)
    local expect = tiniest.expect

    tiniest.test("says hello", function()
        expect(require("../src/greeting").hello("luau")).is("hello from luau")
    end)
end
```

```sh
lx test
```

## Format, lint, and check

```sh
lx fmt
lx lint
lx check
```

`lx fmt` formats Luau sources with stylua. `lx lint` and `lx check` run
[luau-analyze](https://luau.org/analyze) instead of `luacheck`.

## Consume Luau packages from a Lua project

Lux transpiles Luau packages to Lua when they are installed for a Lua runtime, so a
Lua project can depend on them. Native dependencies are not supported in this case.

## Use packages in a Roblox project

See [How to use Lux packages in a Roblox project](/guides/rojo) to build a
Rojo-servable `Packages/` layout with `lx build --preset rojo`.
