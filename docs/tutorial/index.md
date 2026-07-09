---
slug: /
id: intro
title: Introduction
sidebar_label: Tutorial
sidebar_position: 1
---

Welcome to the official `lux` documentation.

Here you will find all sorts of resources ready to get you
started on your Lua journey!

## What is Lux?

`lux` is a package manager for [Lua](https://lua.org). Its purpose is to manage
Lua projects, dependencies, build scripts and more for you, so you
can focus on writing and shipping Lua code.

:::info

Lux is fully functional, but does not have a `1.0` release yet.

:::

## Key Features

#### Create and Manage Lua Projects

- Easily manage dependencies, build steps, and metadata through `lux.toml`.
- Full support for existing `.rockspec` files.

#### Modern, Comfortable Tooling

- Parallel builds and installs.
- Add/remove dependencies with simple CLI commands.
- Integrated code formatting, type checking, and powerful code linting.
- Automatically adds dependencies to `.luarc.json` for rich LSP diagnostics.
- Distribute projects as install tree archives or static binaries without Lua on the target system.

#### Automatic Generation of Rockspecs

- Say goodbye to managing rockspec files by hand.

#### Lua Versioning Done Easy

- Automatically detects and installs the right Lua version for your project (5.1 through 5.5, LuaJIT).

#### Advanced Lockfile Support

- Fully reproducible developer environments with integrity checks.
- Makes Lux easy to integrate with Nix.

#### Fully Compatible with the Ecosystem

- Works with existing LuaRocks packages.
- Use `extra.rockspec` for complex rockspecs you don't want to convert to TOML.
- Shells out to `luarocks` for very complex build scripts ([compare](/explanations/lux-vs-luarocks)).

## Sitemap

The site is divided into sections:
- To install `lux`, head over to the [Getting Started](/tutorial/getting-started) section.
- To learn `lux` by doing, skip over to the [Creating a Project](/tutorial/creating-a-project) section.
- For step-by-step guides to specific tasks, see the [Guides](/guides).
- For detailed reference material, see the [Reference](/reference) section.
- For background and rationale, see the [Explanations](/explanations) section.

## You may also like

- [LuaRocks](https://github.com/luarocks/luarocks) — The original Lua package manager.
- [rocks.nvim](https://github.com/lumen-oss/rocks.nvim) — A Neovim plugin manager that uses LuaRocks under the hood, soon to be rewritten to use Lux.

## Credits

Thanks to the LuaRocks team for maintaining [LuaRocks](https://github.com/luarocks/luarocks) and [luarocks.org](https://luarocks.org) for as long as they have. Without their prior work Lux would not be possible.

## License

- Lux is licensed under [LGPLv3](https://github.com/lumen-oss/lux/blob/master/LICENSE).
- The Lux logo © 2025 by Kai Jakobi is licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

