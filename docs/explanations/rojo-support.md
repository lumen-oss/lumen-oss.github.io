---
id: rojo-support
title: How Lux supports Roblox
---

[Rojo](https://rojo.space) maps a file tree to the Roblox data model. Each
`.lua` and `.luau` file becomes a ModuleScript, and each directory becomes a
Folder. To use installed packages in a Roblox project, Lux has to arrange them
in a layout Rojo can serve.

## The preset

`--preset rojo` pins the Lua version to `luau` and applies a rojo layout.
Run it with the commands that install or build packages:

```sh
lx build --preset rojo
```

## The layout

The layout is written under a project-local `Packages/` folder:

```text
Packages/
├── _Index/<name>@<version>/<name>/   # the package's source, entry point at init.luau
└── <name>.lua                         # require stub
```

- Each package's `src` is copied to `Packages/_Index/<name>@<version>/<name>/`.
- The entry point is `init.luau` or `init.lua`. A package whose module is
  `<name>.luau` or `<name>.lua` gets it copied to `init.<ext>` (the original is kept).
- A `<name>.lua` stub makes the package requireable by name:

  ```lua
  return require(script.Parent._Index["<name>@<version>"]["<name>"])
  ```

- `<version>` drops the spec revision: `0.1.0-1` becomes `0.1.0`.

## Dependencies

The layout applies to the project and to every dependency, including pure-Lua
ones (whose `.lua` entry points Rojo also maps to ModuleScripts).

## Where Lux stops

Lux produces the `Packages/` layout and nothing more. How it reaches the data
model is the user's `default.project.json` (`"Packages": { "$path": "Packages" }`
under a service).
There is no `lx dist rojo`: distribution is
`rojo build` → `.rbxlx`, which is self-contained and includes `Packages/`.
