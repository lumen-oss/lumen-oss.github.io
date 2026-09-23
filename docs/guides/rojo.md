---
id: rojo
title: How to use Lux packages in a Roblox project
---

This guide shows you how to make a Lux project's packages available to a
[Roblox](https://roblox.com) project with [Rojo](https://rojo.space).

## Prerequisites

- A Lux project that declares `lua = "luau"`.
- [Rojo](https://rojo.space/docs/v7/getting-started/installation/) installed.

## Build the package layout

Run `lx build` with the `rojo` preset:

```sh
lx build --preset rojo
```

The preset pins the Lua version to `luau` and generates a `Packages/` folder at
the project root:

```text
Packages/
├── _Index/
│   ├── hello-rojo@0.1.0/
│   │   └── hello-rojo/
│   │       └── init.luau
│   └── foo@1.0.0/
│       └── foo/
│           └── init.lua
├── hello-rojo.lua
└── foo.lua
```

Your project and every dependency are copied in. The `init.luau` (or `init.lua`)
marks each package root as a module, and the `<name>.lua` stub files make them
requireable by name.

## Wire Packages into the data model

Create a `default.project.json` that mounts `Packages/`:

```json title="default.project.json"
{
  "name": "hello-rojo",
  "tree": {
    "$className": "DataModel",
    "ReplicatedStorage": {
      "$className": "ReplicatedStorage",
      "Packages": {
        "$path": "Packages"
      }
    }
  }
}
```

Lux's job ends at the layout; how `Packages/` reaches the data model is defined
by your Rojo project file.

## Require the packages

```lua
local hello = require(game.ReplicatedStorage.Packages["hello-rojo"])
local foo = require(game.ReplicatedStorage.Packages.foo)
```

## Build or serve

```sh
rojo build -o game.rbxl
# or
rojo serve
```

See [How Lux supports Roblox](/explanations/rojo-support) for the details.
