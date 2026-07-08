---
id: lux-toml
title: lux.toml reference
---

:::note
`lux.toml` is a subset of the [Lua rockspec format](https://github.com/luarocks/luarocks/blob/main/docs/rockspec_format.md),
with some simplifications, represented in TOML.
It does not support advanced specifications like platform overrides.
Those can be declared with an [`extra.rockspec`](/guides/rockspec).
:::

## `package`

The name of the rock (mandatory).

```toml
package = "my-lua-project"
```

Lux converts the package name to lower case when [publishing](/guides/publishing).

## `version`

The rock's version (optional).

```toml
version = "1.0.0"
```

Lux supports [SemVer](https://semver.org/) and "Dev" versions.
Versions like `1.0` are corrected to `1.0.0`.
Non-SemVer versions (e.g. `1.0-rc1` instead of `1.0.0-rc1`) are treated as Dev versions
and cannot be compared with SemVer versions.

If unset and the project is in a git repository, Lux searches `HEAD` for a SemVer
git tag (optional `v` prefix). If none is found, the version defaults to `dev`.

## `description`

Metadata published to luarocks.org (optional).

```toml
[description]
summary = "A one-line description of the package"
detailed = """
A longer description of the package
that often spans multiple lines.
"""
license = "GPLv2"
homepage = "https://lumen-oss.github.io"
issues_url = "https://github.com/lumen-oss/lux/issues"
maintainer = "neorocks org"
labels = [ "neovim", "tls", "https" ]
```

## `[source]`

Templates for source URLs for SemVer and dev releases.

```toml
[source]
url = "https://host.com/owner/$(PACKAGE)/archive/refs/tags/$(REF).zip"
dev = "git+https://host.com/owner/$(PACKAGE).git"
```

Variable substitutions:

- `$(PACKAGE)` — package name
- `$(VERSION)` — package version (from git tag if not declared)
- `$(REF)` — git tag or revision (priority: SemVer tag, tag, commit SHA)
- `$(<VAR_NAME>)` — any environment variable

## Dependencies

Five dependency types:

| Field | Purpose |
|---|---|
| `lua` | Lua version constraint |
| `[dependencies]` | Runtime Lua dependencies |
| `[build_dependencies]` | Dependencies needed at build time |
| `[test_dependencies]` | Dependencies for `lx test` |
| `[external_dependencies]` | C/FFI dependencies, found via `pkg-config` |

```toml
lua = ">=5.1"

[dependencies]
luafilesystem = "1.0.0"

[test_dependencies]
busted = ">=2.0.0"
nlua = "~>0.3"

[external_dependencies.OPENSSL]
header = "openssl/ssl.h"
library = "ssl"
```

Operators: `==`, `~=`, `<`, `>`, `<=`, `>=`, `~>`. `~> 2` means `>= 2, < 3`.
Absence of an operator is equivalent to `==`. Version requirements are mandatory.

### Git dependencies

```toml
[dependencies.luafilesystem]
version = "09511782201302ade916d4b250d01a6c61b56844" # commit SHA or tag
git = "github:lunarmodules/luafilesystem"
```

Supported prefixes: `github:` (default if omitted), `gitlab:`, `codeberg:`, `sourcehut:`.
Full HTTPS and SSH URLs are also accepted.

Lux searches the repository root for a `lux.toml` or `.rockspec` to determine the build
specification. Defaults to `builtin` if none is found.

:::important
Rocks with git dependencies cannot be uploaded to LuaRocks.
Git dependencies that require a custom LuaRocks build backend are not supported.
:::

The `rev` field can be used to set a version separate from the checkout target:

```toml
[dependencies.luafilesystem]
version = "scm"
git = "github:lunarmodules/luafilesystem"
rev = "09511782201302ade916d4b250d01a6c61b56844" # commit SHA or tag
```

If `rev` is unset, the `version` field is used as the commit SHA or tag.

### Local dependencies

```toml
[dependencies.foo]
path = "../foo"
version = "1.0.0"
```

## Build specification

:::important
Rocks with C sources require a C compiler. Lux does not bundle one.
:::

### `builtin` (default)

Auto-detects Lua and C sources. C sources are compiled to a Lua module.

```toml
[build]
type = "builtin"

[build.modules]
"foo.main" = "lua/foo.lua"
"foo.bla" = [ "src/bla.c" ]

[build.modules."foo.core"]
sources = [ "src/core.c", "src/extra.c" ]
libraries = [ "ssl" ]
defines = [ "FOO=bar", "USE_BLA" ]
incdirs = [ ]
libdirs = [ ]
```

### `make`

Delegates to Make.

```toml
[build]
type = "make"
makefile = "Makefile"
build_target = ""
build_pass = true
install_target = "install"
install_pass = true
build_variables = {}
install_variables = {}
variables = {}
```

Requires Make.

### `cmake`

Delegates to CMake.

```toml
[build]
type = "cmake"
cmake = """
<content>
"""
variables = []
```

Environment variables: `CMAKE_MODULE_PATH`, `CMAKE_INCLUDE_PATH`, `CMAKE_LIBRARY_PATH`.
Requires CMake.

### `command`

Simple build and install commands.

```toml
[build]
type = "command"
build_command = ""
install_command = ""
```

### `none`

Copies source files without building.

```toml
[build]
type = "none"
```

### `rust-mlua`

Builds rocks written in Rust using [`mlua`](https://crates.io/crates/mlua).

```toml
[build]
type = "rust-mlua"
target_path = "target"
default_features = false
features = []
cargo_extra_args = []

[build.modules]
"foo.main" = "alt_name"

[build.include]
"relative/path/to/file.lua" = "target-file.lua"
```

Requires a [Rust toolchain](https://doc.rust-lang.org/cargo/getting-started/installation.html).

### `treesitter-parser`

Builds tree-sitter parsers without requiring tree-sitter CLI.

```toml
[build]
type = "treesitter-parser"
lang = "<lang>"
parser = true
generate = true
generate_from_json = false
location = "libs/tree-sitter-<lang>"

[build.queries."highlights.scm"] = """
(signature
  name: (variable) @function)
"""
```

### Custom LuaRocks build backends

Custom Lua build backends are supported by delegating to LuaRocks.

### `[build.install.*]`

Installs files by category:

```toml
[build.install.lua]
"foo.bar" = "src/bar.lua"

[build.install.lib]
"foo.bar" = "lib/bar.so"

[build.install.conf]

[build.install.bin]
```

### `copy_directories`

Directories copied to the rock's `etc` tree as-is.

```toml
[build]
copy_directories = [ "plugin", "ftplugin" ]
```

:::important
Do not use `"lua"`, `"lib"`, or `"rock_manifest"` — they clash with LuaRocks.
:::

### Patches

Embedded patch files:

```toml
[build.patches]
"lua51-support.diff" = """
--- old/mymodule.c....
"""
```

Lux supports any format supported by the [diffy crate](https://docs.rs/diffy/0.4.2/diffy/).
LuaRocks only supports unified diff.

## Test specification

### `busted`

```toml
[test]
type = "busted"
flags = [ ]
```

Defaults to `busted` if a `.busted` file exists and no test backend is specified.

### `busted-nlua`

Runs busted with Neovim as the Lua interpreter.

```toml
[test]
type = "busted-nlua"
flags = [ ]
```

Currently broken on macOS and Windows. Defaults to `busted-nlua` if a `.busted` file exists
or `busted` and `nlua` are `test_dependencies`, and no test backend is specified.

### `command`

```toml
[test]
type = "command"
command = "make"
flags = [ "test" ]
```

### `script`

```toml
[test]
type = "script"
script = "tests.lua"
flags = [ ]
```
