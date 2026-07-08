---
id: formatting-linting
title: How to format and lint a Lua project
---

This guide shows you how to format, type-check, and lint your Lua project.

## `lx fmt`

```sh
lx fmt
```

By default, formatting follows the [Roblox Lua Style Guide](https://roblox.github.io/lua-style-guide/).
To configure it, create a `.stylua.toml` or `stylua.toml` in the project root:

```toml title=".stylua.toml"
syntax = "All"
column_width = 120
line_endings = "Unix"
indent_type = "Tabs"
indent_width = 4
quote_style = "AutoPreferDouble"
call_parentheses = "Always"
collapse_simple_statement = "Never"
space_after_function_names = "Never"

[sort_requires]
enabled = false
```

See `lx fmt --help` for available options.

## Type checks with LuaCATS annotations

Run `lx check` to statically type-check your codebase with [emmylua_check](https://github.com/EmmyLuaLs/emmylua-analyzer-rust),
using [LuaCATS annotations](https://github.com/EmmyLuaLs/emmylua-analyzer-rust).

The command builds your project and its dependencies (if needed),
generates workspace library entries for a [`.luarc.json` file](https://github.com/LuaLS/lua-language-server/wiki/Configuration-File),
and runs the static checker.

See `lx check --help` for available options.

## Linting with `luacheck`

```sh
lx lint
```

See `lx lint --help` for available options.

## Git Hooks

To run checks, lints, and formatting before each commit, create a
`.git/hooks/pre-commit` file in your project directory:

```sh
#!/bin/sh

lx check
lx lint
lx fmt
```

Make sure to make the file executable:

```sh
chmod +x .git/hooks/pre-commit
```
