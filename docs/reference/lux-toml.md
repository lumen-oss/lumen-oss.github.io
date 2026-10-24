---
id: lux-toml
title: lux.toml reference
---

<!-- This file is auto-generated from the Lux schema. Do not edit manually. -->
<!-- Regenerate with: scripts/src/generate-schema-reference.lua -->
<!-- Generated from lux-cli 0.49.1 -->

# lux.toml

Download the [JSON Schema](/schemas/lux-toml.schema.json).

The TOML manifest for a Lux project.

`lux.toml` is a subset of the [Lua rockspec format](https://github.com/luarocks/luarocks/blob/main/docs/rockspec_format.md),
with some simplifications, represented in TOML.
It does not support advanced specifications like platform overrides.
Those can be declared with an [`extra.rockspec`](https://lux.lumen-labs.org/guides/rockspec).


## package
**Type:** string

The name of the rock. Lux converts it to lower case when publishing.

```toml
package = "my-lua-project"
```


## version
**Type:** string

The package version. If unset, Lux derives it from the current SemVer
git tag (optional `v` prefix), falling back to "dev".

Versions like `1.0` are corrected to `1.0.0`.
Non-SemVer versions (e.g. `1.0-rc1` instead of `1.0.0-rc1`) are treated
as Dev versions and cannot be compared with SemVer versions.

```toml
version = "1.0.0"
```


## build
**Type:** object

How to build the project. See the build backend fields below.

Rocks with C sources require a C compiler. Lux does not bundle one.


### type
**Type:** string

The build backend to use: "builtin", "make", "cmake",
"command", "none", "rust-mlua", "rust-binary", or "treesitter-parser".
Any other value is treated as a custom LuaRocks build backend.
Default: "builtin".

`make` requires Make, `cmake` requires CMake, and `rust-mlua`/`rust-binary`
require a Rust toolchain. Set `type = "none"` to copy source files
without building.

For Luau projects, `builtin` auto-detects `.luau` modules. Native
dependencies are not supported. Luau modules are transpiled to Lua when
the project targets a Lua runtime.

```toml
[build]
type = "builtin"
```


### modules
**Type:** map of `string` to string or array of string or object

Modules to build, mapping module names (as used by `require`) to a source
path, a list of C sources, or a table with `sources`, `libraries`,
`defines`, `incdirs`, and `libdirs`.

```toml
[build.modules]
"foo.main" = "lua/foo.lua"
"foo.bla" = ["src/bla.c"]

[build.modules."foo.core"]
sources = ["src/core.c", "src/extra.c"]
libraries = ["ssl"]
defines = ["FOO=bar", "USE_BLA"]
incdirs = []
libdirs = []
```


### makefile
**Type:** string

Makefile to use. Default: "Makefile" ("Makefile.win" on Windows).

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


### build_target
**Type:** string

Target passed to `make` during the build pass. Default: empty.


### build_pass
**Type:** boolean

Whether to perform a build pass. Default: `true`.


### install_target
**Type:** string

Target passed to `make` during the install pass. Default: "install".


### install_pass
**Type:** boolean

Whether to perform an install pass. Default: `true`.


### build_variables
**Type:** map of `string` to string

Make variable assignments for the build pass.


### install_variables
**Type:** map of `string` to string

Make variable assignments for the install pass.


### variables
**Type:** map of `string` to string

Make or CMake variable assignments applied to both passes.


### cmake
**Type:** string

Contents of the generated "CMakeLists.txt". If unset, the project's own
file is used.

Environment variables: `CMAKE_MODULE_PATH`, `CMAKE_INCLUDE_PATH`,
`CMAKE_LIBRARY_PATH`.

```toml
[build]
type = "cmake"
cmake = """
<content>
"""
```


### build_command
**Type:** string

Command to run to build the package.

```toml
[build]
type = "command"
build_command = "make"
install_command = "make install"
```


### install_command
**Type:** string

Command to run to install the package.


### install
**Type:** object

Files to install, by category ("lua", "lib", "conf", "bin").

```toml
[build.install.lua]
"foo.bar" = "src/bar.lua"

[build.install.lib]
"foo.bar" = "lib/bar.so"

[build.install.conf]

[build.install.bin]
```


#### lua
**Type:** map of `string` to string

Lua modules written in Lua.


#### lib
**Type:** map of `string` to string

Dynamic libraries implemented compiled Lua modules.


#### conf
**Type:** map of `string` to string

Configuration files.


#### bin
**Type:** map of `string` to string

Lua command-line scripts.


### copy_directories
**Type:** array of string

Directories in the source tree to copy as-is into the rock's "etc" tree.
Do not use "lua", "lib", "rock_manifest", or the rockspec file name.

```toml
[build]
copy_directories = ["plugin", "ftplugin"]
```


### patches
**Type:** map of `string` to string

Patches to apply before building, mapping file names to patch contents.
Lux accepts any format supported by the [`diffy`](https://docs.rs/diffy/latest/diffy/) crate.
LuaRocks only supports unified diff.

```toml
[build.patches]
"lua51-support.diff" = """
--- old/mymodule.c....
"""
```


### target_path
**Type:** string

The cargo target directory, if it is not `<source>/target`.

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


### default_features
**Type:** boolean

Whether to build a cargo package with default features. Default: `true`.


### features
**Type:** array of string

Cargo features to enable.


### cargo_extra_args
**Type:** array of string

Additional arguments to pass to cargo.


### package
**Type:** string

The cargo package to build.
Required for "rust-binary" in multi-package workspaces.


### include
**Type:** map of `string` to string

Additional files to copy into the rock's "lua" directory, mapping source
paths to destinations.


### lang
**Type:** string

The parser language, e.g. "haskell". Required for "treesitter-parser".

```toml
[build]
type = "treesitter-parser"
lang = "haskell"
parser = true
generate = true
location = "libs/tree-sitter-haskell"

[build.queries."highlights.scm"] = """
(signature
  name: (variable) @function)
"""
```


### parser
**Type:** boolean

Whether to build the tree-sitter parser. Set to `false` for query-only packages.
Default: `false`.


### generate
**Type:** boolean

Whether to generate the tree-sitter parser sources before building.
Default: `false`.


### location
**Type:** string

Location of the tree-sitter grammar, relative to the source root.


### queries
**Type:** map of `string` to string

Embedded queries to install into "etc/queries", mapping file names to
contents.


## rockspec_format
**Type:** one of "1.0", "2.0", "3.0"

The LuaRocks rockspec format version to write to the generated rockspec ("1.0", "2.0", or "3.0").
Default: "3.0".

```toml
rockspec_format = "3.0"
```


## run
**Type:** object

How to run the project with `lx run`.

```toml
[run]
args = ["src/main.lua"]
```


### command
**Type:** string

The command to execute when running the project


### args
**Type:** array of string

Arguments to pass to the command


## lua
**Type:** string

The Lua version requirement, e.g. "&gt;= 5.1". Required to build a rockspec.
Set to "luau" to build and run the project with Luau.

```toml
lua = ">=5.1"
```


## description
**Type:** object

Metadata published to LuaRocks.

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
labels = ["neovim", "tls", "https"]
```


### summary
**Type:** string

A one-line description of the package.


### detailed
**Type:** string

A longer description of the package.


### license
**Type:** string

The license used by the package.


### homepage
**Type:** string

An URL for the project. This is not the URL for the tarball, but the address of a website.


### issues_url
**Type:** string

An URL for the project's issue tracker.


### maintainer
**Type:** string

Contact information for the rockspec maintainer.


### labels
**Type:** array of string

A list of short strings that specify labels for categorization of this rock.


## supported_platforms
**Type:** map of `string` to boolean

Platforms this rock supports, mapping platform identifiers to `true` or
`false` (e.g. `linux = true`).

```toml
[supported_platforms]
linux = true
windows = false
```


## dependencies
**Type:** map of `string` to string or object

Runtime Lua dependencies, mapping package names to a version requirement
(e.g. `foo = "1.0"`) or to a detailed table with `version`, `opt`, `pin`,
`git`, `rev`, and `path` keys.

Version requirements support the operators `==`, `~=`, `<`, `>`, `<=`,
`>=`, and `~>`. `~> 2` means `>= 2, < 3`. An operator is optional;
without one, the requirement is treated as `==`. Version requirements
are mandatory.

Dependencies are declared under `lua`, `[dependencies]`,
`[build_dependencies]`, `[test_dependencies]`, and
`[external_dependencies]`.

Git dependencies support the `github:` (default), `gitlab:`,
`codeberg:`, and `sourcehut:` shorthands, as well as full HTTPS and SSH
URLs. If `rev` is unset, `version` is used as the commit SHA or tag.
Lux searches the repository root for a `lux.toml` or `.rockspec` to
determine the build specification, defaulting to `builtin` if none is
found. Rocks with git dependencies cannot be published to LuaRocks. Git
dependencies that require a custom LuaRocks build backend are not
supported.

```toml
[dependencies]
luafilesystem = "1.0.0"

[dependencies.argparse]
version = "0.7"
opt = true

[dependencies.foo]
version = "09511782201302ade916d4b250d01a6c61b56844"
git = "github:lunarmodules/foo"

[dependencies.bar]
path = "../bar"
version = "1.0.0"
```


## build_dependencies
**Type:** map of `string` to string or object

Dependencies needed at build time. Same syntax as `dependencies`.


## external_dependencies
**Type:** map of `string` to object

System (C/FFI) dependencies, discovered via pkg-config. Each entry may
set `header` and/or `library`.

```toml
[external_dependencies.OPENSSL]
header = "openssl/ssl.h"
library = "ssl"
```


## test_dependencies
**Type:** map of `string` to string or object

Dependencies needed when running `lx test`. Same syntax as `dependencies`.

```toml
[test_dependencies]
busted = ">=2.0.0"
nlua = "~>0.3"
```


## source
**Type:** object

Templates for generating the source URL of a release.

Variable substitutions:
- `$(PACKAGE)`: package name
- `$(VERSION)`: package version (from the git tag if not declared)
- `$(REF)`: git tag or revision (priority: SemVer tag, tag, commit SHA)
- `$(<VAR_NAME>)`: any environment variable

```toml
[source]
url = "https://host.com/owner/$(PACKAGE)/archive/refs/tags/$(REF).zip"
dev = "git+https://host.com/owner/$(PACKAGE).git"
```


### url
**Type:** string

URL template for `SemVer` releases


### dev
**Type:** string

URL template for `DevVer` releases


### file
**Type:** string

File name of the source archive.
Can be omitted if it can be inferred from the generated URL.


### dir
**Type:** string

Name of the directory created when the source archive is unpacked.
Can be omitted if it can be inferred from the `file` field.


### tag
**Type:** string

The tag or revision to be checked out if the source URL is a git source.
If unset, Lux will try to auto-detect it.


### branch
**Type:** string

The branch to be checked out if the source URL is a git source.


## test
**Type:** object

How to run the test suite with `lx test`.

The `busted` backend is used when a `.busted` file exists and no backend
is specified. `busted-nlua` is used when a `.busted` file exists or
`busted` and `nlua` are `test_dependencies`. The `busted-nlua` backend is
currently broken on macOS and Windows. Luau projects default to `tiniest`.

```toml
[test]
type = "busted"
flags = []
```


### type
**Type:** one of "busted", "busted-nlua", "tiniest", "command"

The test backend: "busted", "busted-nlua", "tiniest", or "command".
If unset, Lux auto-detects a backend (e.g. "busted" when a ".busted"
file or the "busted" dependency is present).


### flags
**Type:** array of string

Extra CLI flags to pass to the test backend.


### command
**Type:** string

Shell command to run as the test suite. Mutually exclusive with `script`.

```toml
[test]
type = "command"
command = "make"
flags = ["test"]
```


### script
**Type:** string

Lua script to run as the test suite. Mutually exclusive with `command`.

```toml
[test]
type = "script"
script = "tests.lua"
flags = []
```


## deploy
**Type:** object

Additional install and deployment options.

```toml
[deploy]
wrap_bin_scripts = false
```


### wrap_bin_scripts
**Type:** boolean

Whether to wrap installed Lua bin scripts to be executed with
the detected or configured Lua installation.
Defaults to `true`.


## project
**Type:** object

Lux-specific project settings, ignored when generating a rockspec.

```toml
[project]
root_dir = ".."
```


### root_dir
**Type:** string

The project root directory, relative to the directory containing the `lux.toml`.
Useful for multi-project workspaces, where the build files
(e.g. the cargo workspace `Cargo.toml`) do not live next to the `lux.toml`.


