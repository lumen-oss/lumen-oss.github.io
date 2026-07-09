---
slug: /explanations/architecture
id: architecture
title: Architecture
---

Lux is distributed as several packages that can be used independently.

## `lux-cli`

The command-line interface. This is what most users interact with.
It provides all `lx` commands for creating projects, managing dependencies,
building, formatting, linting, and more.

## `lux-lua`

The Lua API that Lux installs alongside your project's dependencies.
It provides:

- `lux.loader` — Resolves dependencies at runtime when a script calls `require`.
- An API for embedding Lux into Lua applications.

`lux-cli` uses `lux-lua` for commands like `lx lua`, `lx run`, and `lx path`.

`lux-lua` is built for Lua 5.1, 5.2, 5.3, 5.4, 5.5, and LuaJIT.
Prebuilt binaries are bundled with Lux releases and include `lux-lua` for
all supported versions.

Lux detects a `lux-lua` installation via `pkg-config` or the
`LUX_LIB_DIR` environment variable.

## `lux-lib`

The Rust library that implements Lux's core logic. It is a dependency of
both `lux-cli` and `lux-lua`, but is not typically used directly by end users.
