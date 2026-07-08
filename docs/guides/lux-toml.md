---
id: lux-toml
title: How to declare a lux.toml file
sidebar_position: 3
---

This guide shows you how to configure the core sections of a `lux.toml`.
For a complete field listing, see the [lux.toml reference](/reference/lux-toml).

## Minimum required fields

At a minimum, your `lux.toml` needs a package name:

```toml
package = "my-lua-project"
```

If the project is in a git repository with a SemVer tag, the version is inferred
automatically. Otherwise, declare it explicitly:

```toml
version = "0.1.0"
```

## Declaring dependencies

Add runtime dependencies under `[dependencies]`:

```toml
[dependencies]
argparse = "0.7"
```

Use `[test_dependencies]` for test-only dependencies and
`[build_dependencies]` for build-time dependencies.

Use `lx add <package>` to add dependencies from the CLI.
See `lx add --help` for available options.

## Adding a source URL

When [publishing](/guides/publishing), configure the source URL template:

```toml
[source]
url = "https://github.com/my-username/my-project/archive/refs/tags/$(REF).zip"
```

## Picking a build backend

By default, Lux uses the `builtin` backend, which detects Lua and C sources
automatically. Set a different backend with:

```toml
[build]
type = "make"
```

See the [lux.toml reference](/reference/lux-toml) for all available backends.

## Configuring the test suite

```toml
[test]
type = "busted"
```

## Adding package metadata (optional)

```toml
[description]
summary = "A one-line description"
license = "MIT"
```

## Next steps

For a full reference of all fields, build backends, and test options, see the
[lux.toml reference](/reference/lux-toml).
