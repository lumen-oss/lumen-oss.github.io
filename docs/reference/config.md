---
id: config
---

<!-- This file is auto-generated from the Lux schema. Do not edit manually. -->
<!-- Regenerate with: scripts/src/generate-schema-reference.lua -->
<!-- Generated from lux-cli 0.49.0 -->

# config.toml

Download the [JSON Schema](/schemas/config.schema.json).

Configuration for Lux, located at the path reported by `lx config`.


## server
**Type:** string

The LuaRocks repository server to fetch rocks and rockspecs from.
Default: "https://luarocks.org/".


## extra_servers
**Type:** array of string

Additional LuaRocks repository servers.


## manifest_cache_url
**Type:** string


## no_manifest_cache
**Type:** boolean


## extra_wally_registries
**Type:** array of string

Additional wally package registries (git-index URLs), in addition to the
official wally index.


## namespace
**Type:** string

The LuaRocks server namespace to use.


## lua_version
**Type:** one of "5.1", "5.2", "5.3", "5.4", "5.5", "jit", "jit5.2", "luau"

The Lua version to use. Default: the detected installed Lua version.


## user_tree
**Type:** string

The tree in which to install rocks.


## workspace_tree
**Type:** string

The tree to use when in a workspace.
Default: a ".lux" directory in the workspace root.


## lua_dir
**Type:** string

The directory in which to install Lua if it is not found.


## cache_dir
**Type:** string

The cache directory, e.g. for LuaRocks manifests.


## data_dir
**Type:** string

The data directory, in which the default user install tree resides.


## vendor_dir
**Type:** string

A directory with locally vendored sources and rockspecs, used instead of
a remote server.


## enable_development_packages
**Type:** boolean

Whether to fetch development/scm rocks. Default: `false`.


## verbose
**Type:** boolean

Whether to display verbose output of executed commands. Default: `false`.


## no_progress
**Type:** boolean

Whether to disable progress bars and spinners. Default: `false`.


## no_prompt
**Type:** boolean

Whether to skip prompts, selecting the default option. Default: `false`.


## timeout
**Type:** integer

Timeout for network operations, in seconds. `0` disables the timeout.
Default: `30`.


## max_jobs
**Type:** integer

Maximum number of parallel jobs, e.g. for downloads and installs.
`0` means no limit.


## variables
**Type:** map of `string` to string

Variable names mapped to their values. Lux substitutes these in the
`lux.toml` and in rockspecs before building.


## access_tokens
**Type:** map of `string` to string

Access tokens for fetching sources from private hosts, mapped by host.
These can also be set via the `LUX_ACCESS_TOKENS` environment variable.


## external_deps
**Type:** object

Used as a fallback when searching for external dependencies if they
cannot be found using pkg-config.


### bin_patterns
**Type:** array of string

Patterns for binary files


### include_patterns
**Type:** array of string

Patterns for header files


### lib_patterns
**Type:** array of string

Patterns for library files


### bin_subdir
**Type:** string

Default binary subdirectory


### include_subdir
**Type:** string

Default include subdirectory


### lib_subdirs
**Type:** array of string

Default library subdirectory


### search_prefixes
**Type:** array of string

System-wide search paths


### prefixes
**Type:** map of `string` to string

Known installation prefixes for specific dependencies.
These can also be set via environment variables.


## build
**Type:** object

Configuration for the build process.


### profile
**Type:** one of "release", "dev"

The build profile to use when compiling packages.
Default: [`BuildProfile::Release`]


### runner
**Type:** array of string

Command prefix with which to wrap all build commands.

If set, every command spawned by the build backends is invoked as
`runner + [command, arguments...]`.

If unset, no wrapping is performed.


## user_agent
**Type:** string

The user agent to use when making web requests.
Default: "lux/&lt;version&gt;" (CLI), "lux-lua/&lt;version&gt;" (lux-lua) or "lux-lib/&lt;version&gt;".


## generate_luarc
**Type:** boolean

Whether to generate a ".luarc.json" on build. Default: `true`.


## luarc_file_name
**Type:** string

The Lua language server configuration file name. Default: ".luarc.json".


## wrap_bin_scripts
**Type:** boolean

Whether to wrap installed Lua bin scripts to run with the detected or
configured Lua installation. Default: `true`.


## package_types
**Type:** object

Which package types to include in searches.


### rockspec
**Type:** boolean

Include Rockspec


### src
**Type:** boolean

Include Src


### binary
**Type:** boolean

Include Binary


## no_tfa
**Type:** boolean

Whether to disable prompts for two-factor authentication (2FA) codes.
Default: `false`.


