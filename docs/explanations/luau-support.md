---
id: luau-support
title: How Lux supports Luau
---

[Luau](https://luau.org) is a gradually-typed dialect of Lua.
It is a superset of Lua, adding type annotations, a richer standard library, and a
sandboxed runtime.

Lux treats Luau as a first-class target: you can create, install, build, run, and
test Luau projects, and Lua projects can consume Luau packages.

## The model

Lux models Luau as a single `LuaVersion::Luau` that maps to the 5.1 API level.

The runtime is the `luau` or `lune` binary. Lux detects it on the `PATH`, probes
`pkg-config`, and falls back to building `luau` from source. Set the `LUAU`
variable to pin a specific runtime.

## Module resolution

The `luau` runtime has no `package` table, `dofile`, or `loadfile`; `require`
resolves only `./`, `../`, and `@`-prefixed aliases from a `.luaurc` file. Lux
therefore generates a `.luaurc` that maps each dependency (`@package`) to its
installed source directory, replacing `LUA_PATH` and the `lux.loader`.

## Building

The `builtin` backend auto-detects `.luau` modules. Native (C) dependencies are
not supported under Luau: neither the `luau` CLI nor Lune can load shared
libraries.

## Transpiling to Lua

When a Luau package is installed for a Lua runtime, Lux transpiles it:

- Luau syntax is lowered (types, compound assignment, string
  interpolation, `continue`, if-expressions, `const`, and more).
- Luau-only standard library functions are shimmed on demand (`table.create`,
  `string.split`, `bit32`, `utf8`, and others).
- `require` paths are flattened to Lua module names.

`task.*` and `buffer.*` are not supported when transpiling.

## Roblox

Lux can arrange installed packages in a Rojo-servable layout. See
[How Lux supports Roblox](/explanations/rojo-support).
