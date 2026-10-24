---
id: lux-toml-schema
---

<!-- This file is auto-generated from the Lux schema. Do not edit manually. -->
<!-- Regenerate with: scripts/src/generate-schema-reference.lua -->
<!-- Generated from lux-cli 0.49.0 -->

# lux.toml

See also the [lux.toml reference](/reference/lux-toml).
Download the [JSON Schema](/schemas/lux-toml.schema.json).

The TOML manifest for a Lux project.


## package
**Type:** string

The name of the rock.


## version
**Type:** string

The package version. If unset, Lux derives it from the current SemVer
git tag, falling back to "dev".


## build
**Type:** object

How to build the project. See the build backend fields below.


### type
**Type:** string

The build backend to use: "builtin", "make", "cmake",
"command", "none", "rust-mlua", "rust-binary", or "treesitter-parser".
Any other value is treated as a custom LuaRocks build backend.
Default: "builtin".


### modules
**Type:** map of `string` to string or array of string or object

Modules to build, mapping module names (as used by `require`) to a source
path, a list of C sources, or a table with `sources`, `libraries`,
`defines`, `incdirs`, and `libdirs`.


### makefile
**Type:** string

Makefile to use. Default: "Makefile" ("Makefile.win" on Windows).


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


### build_command
**Type:** string

Command to run to build the package.


### install_command
**Type:** string

Command to run to install the package.


### install
**Type:** object

Files to install, by category ("lua", "lib", "conf", "bin").


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


### patches
**Type:** map of `string` to string

Patches to apply before building, mapping file names to patch contents.
Lux accepts any format supported by the [`diffy`](https://docs.rs/diffy/latest/diffy/) crate.


### target_path
**Type:** string

The cargo target directory, if it is not `<source>/target`.


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


## run
**Type:** object

How to run the project with `lx run`.


### command
**Type:** string

The command to execute when running the project


### args
**Type:** array of string

Arguments to pass to the command


## lua
**Type:** string

The Lua version requirement, e.g. "&gt;= 5.1". Required to build a rockspec.


## description
**Type:** object

Metadata published to LuaRocks.


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


## dependencies
**Type:** map of `string` to string or object

Runtime Lua dependencies, mapping package names to a version requirement
(e.g. `foo = "1.0"`) or to a detailed table with `version`, `opt`, `pin`,
`git`, `rev`, and `path` keys.


## build_dependencies
**Type:** map of `string` to string or object

Dependencies needed at build time. Same syntax as `dependencies`.


## external_dependencies
**Type:** map of `string` to object

System (C/FFI) dependencies, discovered via pkg-config. Each entry may
set `header` and/or `library`.


## test_dependencies
**Type:** map of `string` to string or object

Dependencies needed when running `lx test`. Same syntax as `dependencies`.


## source
**Type:** object

Templates for generating the source URL of a release.


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


### script
**Type:** string

Lua script to run as the test suite. Mutually exclusive with `command`.


## deploy
**Type:** object

Additional install and deployment options.


### wrap_bin_scripts
**Type:** boolean

Whether to wrap installed Lua bin scripts to be executed with
the detected or configured Lua installation.
Defaults to `true`.


## project
**Type:** object

Lux-specific project settings, ignored when generating a rockspec.


### root_dir
**Type:** string

The project root directory, relative to the directory containing the `lux.toml`.
Useful for multi-project workspaces, where the build files
(e.g. the cargo workspace `Cargo.toml`) do not live next to the `lux.toml`.


