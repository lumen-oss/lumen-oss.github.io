---
id: formatting-linting
title: How to format and lint a Lua project
---

In this guide, we'll learn how to keep our codebase clean and maintainable with formatting
and linting tools.

## `lx fmt`

In Lux, formatting is done via a bundled implementation of [`stylua`](https://github.com/JohnnyMorganz/StyLua).

By default, `lx fmt` will loosely follow the [Roblox Lua Style Guide](https://roblox.github.io/lua-style-guide/).
To configure the formatting behaviour, create a `.stylua.toml` or `stylua.toml` in the
root of your project. Below is an example file:

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

## Type checks with LuaCATS annotations

Lua is incredibly responsive when used for configuration or scripting, giving immediate feedback.
But in the context of a project that needs to be maintained long-term, its dynamic typing casts
shadows of unpredictability, making Lua projects susceptible to unexpected bugs at the wrong time.

To help mitigate this, Lux provides a `lx check` command, which uses [emmylua_check](https://github.com/EmmyLuaLs/emmylua-analyzer-rust)
to statically type-check your codebase based on [LuaCATS annotations](https://github.com/EmmyLuaLs/emmylua-analyzer-rust).

The command will:

1. Build your project and its dependencies if not done already.
2. Generate workspace library entries for a [`.luarc.json` file](https://github.com/LuaLS/lua-language-server/wiki/Configuration-File).
3. Run the static checker.

## Linting with `luacheck`

Linting is the process of analyzing code for stylistic and logic error (lines too long, unused variables, etc.).
Lux comes with `luacheck`, a linter for Lua code, built-in. To run `luacheck` on your project, use the following command:

```sh
lx lint
```

We recommend running checks and lints automatically through a git hook,
or running them manually at the end of every significant addition/refactor of your code.

## Git Hooks

We recommend setting up a Git hook to run `lx check`, `lx lint` and `lx fmt` before
each commit to ensure that you never forget to lint and format your code.

To set up a Git hook, create a file called `.git/hooks/pre-commit` in your
project directory with the following content:

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
