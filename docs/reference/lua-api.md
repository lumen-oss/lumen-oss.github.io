---
id: lua-api
title: Lua API reference
---

<!-- This file is auto-generated from the lux-luajit type definitions. Do not edit manually. -->
<!-- Regenerate with: scripts/src/generate-lua-api-reference.lua -->

# Lua API reference (0.35.3)

The entry point to the Lua API is the [`LuxModule`](#class-luxmodule), returned by `require("lux")`.
It exposes sub-modules for configuration, operations, projects, and workspaces:

- `lux.config`: [`ConfigModule`](#class-configmodule)
- `lux.operations`: [`OperationsModule`](#class-operationsmodule)
- `lux.project`: [`ProjectModule`](#class-projectmodule)
- `lux.workspace`: [`WorkspaceModule`](#class-workspacemodule)

## class LuxModule

---

### methods
---

#### LuxModule.loader
---
```lua
function LuxModule.loader(self: LuxModule {
    config = ConfigModule,
    operations = OperationsModule,
    project = ProjectModule,
    workspace = WorkspaceModule,
    loader = function,
})
```

Load the lux loader into the current Lua session

### fields
---

#### LuxModule.config
---
```lua
LuxModule.config : ConfigModule {
    builder: function,
    default: function,
    new: function,
}
```

Module for building a Lux `Config`

#### LuxModule.operations
---
```lua
LuxModule.operations : OperationsModule {
    build: function,
    dist_bin: function,
    download_rockspec: function,
    install: function,
    pin: function,
    search: function,
    sync: function,
    sync_build_dependencies: function,
    sync_dependencies: function,
    sync_test_dependencies: function,
    uninstall: function,
    update: function,
    ...(+0)
}
```

Module for Lux operations

#### LuxModule.project
---
```lua
LuxModule.project : ProjectModule {
    new: function,
}
```

Module for interacting with a Lux project

#### LuxModule.workspace
---
```lua
LuxModule.workspace : WorkspaceModule {
    current: function,
    new: function,
    new_fuzzy: function,
}
```

Module for interacting with a Lux workspace


## class BuildSpec

The build specification for a given rock, serialized from `build = { ... }`.

---

### methods
---

#### BuildSpec.build_backend
---
```lua
function BuildSpec.build_backend(self: BuildSpec {
    build_backend = function,
    copy_directories = function,
    install = function,
    patches = function,
}) ->  table?
```

Determines the build backend to use

#### BuildSpec.copy_directories
---
```lua
function BuildSpec.copy_directories(self: BuildSpec {
    build_backend = function,
    copy_directories = function,
    install = function,
    patches = function,
}) ->  string[]
```

A list of directories that should be copied as-is into the resulting rock

#### BuildSpec.install
---
```lua
function BuildSpec.install(self: BuildSpec {
    build_backend = function,
    copy_directories = function,
    install = function,
    patches = function,
}) ->  InstallSpec {
    bin = function,
    conf = function,
    lib = function,
    lua = function,
}
```

A set of instructions on how/where to copy files from the project

#### BuildSpec.patches
---
```lua
function BuildSpec.patches(self: BuildSpec {
    build_backend = function,
    copy_directories = function,
    install = function,
    patches = function,
}) ->  { [string]: string }
```

A list of patches to apply to the project before packaging it


## class BustedTestSpec

Specification for running a test suite with busted

---

### methods
---

#### BustedTestSpec.flags
---
```lua
function BustedTestSpec.flags(self: BustedTestSpec {
    flags = function,
}) ->  string[]
```

Additional CLI flags to pass to busted when running


## class CMakeBuildSpec

Specification for building a rock with the `cmake` build backend

---

### methods
---

#### CMakeBuildSpec.build_pass
---
```lua
function CMakeBuildSpec.build_pass(self: CMakeBuildSpec {
    build_pass = function,
    cmake_lists_content = function,
    install_pass = function,
    variables = function,
}) ->  boolean
```

Whether to perform a build pass

#### CMakeBuildSpec.cmake_lists_content
---
```lua
function CMakeBuildSpec.cmake_lists_content(self: CMakeBuildSpec {
    build_pass = function,
    cmake_lists_content = function,
    install_pass = function,
    variables = function,
}) ->  string?
```

#### CMakeBuildSpec.install_pass
---
```lua
function CMakeBuildSpec.install_pass(self: CMakeBuildSpec {
    build_pass = function,
    cmake_lists_content = function,
    install_pass = function,
    variables = function,
}) ->  boolean
```

Whether to perform an install pass

#### CMakeBuildSpec.variables
---
```lua
function CMakeBuildSpec.variables(self: CMakeBuildSpec {
    build_pass = function,
    cmake_lists_content = function,
    install_pass = function,
    variables = function,
}) ->  { [string]: string }
```


## class CommandBuildSpec

Specification for building a rock with the `command` build backend

---

### methods
---

#### CommandBuildSpec.build_command
---
```lua
function CommandBuildSpec.build_command(self: CommandBuildSpec {
    build_command = function,
    install_command = function,
}) ->  string?
```

#### CommandBuildSpec.install_command
---
```lua
function CommandBuildSpec.install_command(self: CommandBuildSpec {
    build_command = function,
    install_command = function,
}) ->  string?
```


## class CommandTestSpec

Specification for running a test suite with a command

---

### methods
---

#### CommandTestSpec.command
---
```lua
function CommandTestSpec.command(self: CommandTestSpec {
    command = function,
    flags = function,
}) ->  string
```

The command to run

#### CommandTestSpec.flags
---
```lua
function CommandTestSpec.flags(self: CommandTestSpec {
    command = function,
    flags = function,
}) ->  string[]
```

Additional CLI flags to pass to the command when running


## class Config

The resolved configuration for a Lux session.
Can be constructed via `ConfigBuilder`, which supports layering multiple
configuration sources (config file, CLI flags, environment variables)

---

### methods
---

#### Config.builder
---
```lua
function Config.builder() ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```

#### Config.cache_dir
---
```lua
function Config.cache_dir(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  string
```

The Lux cache directory

#### Config.cmake_cmd
---
```lua
function Config.cmake_cmd(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  string
```

Command to use for running `cmake` builds

#### Config.data_dir
---
```lua
function Config.data_dir(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  string
```

The Lux data directory

#### Config.enabled_dev_servers
---
```lua
function Config.enabled_dev_servers(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  string[]
```

Enabled luarocks repository servers that provide dev/scm rocks

#### Config.entrypoint_layout
---
```lua
function Config.entrypoint_layout(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  RockLayoutConfig {
    new = function,
    new_nvim_layout = function,
}
```

The rock layout for entrypoints of new install trees.
Does not affect existing install trees or dependency rock layouts.

#### Config.extra_servers
---
```lua
function Config.extra_servers(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  string[]
```

Additional luarocks repository servers

#### Config.lua_dir
---
```lua
function Config.lua_dir(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  string?
```

The directory in which to install Lua&#123;n&#125; if not found

#### Config.make_cmd
---
```lua
function Config.make_cmd(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  string
```

Command to use for running `make` builds

#### Config.namespace
---
```lua
function Config.namespace(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  string?
```

The luarocks server namespace to use

#### Config.no_progress
---
```lua
function Config.no_progress(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  boolean
```

Whether to disable printing progress bars and spinners

#### Config.no_prompt
---
```lua
function Config.no_prompt(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  boolean
```

Whether to skip prompts, selecting the default option

#### Config.server
---
```lua
function Config.server(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  string
```

The luarocks repository server

#### Config.timeout
---
```lua
function Config.timeout(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  integer
```

Timeout on network operations, in seconds.
0 means no timeout (wait forever).

#### Config.user_tree
---
```lua
function Config.user_tree(
  self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
},
  lua_version: ("5.1"|"5.2"|"5.3"|"5.4"|"5.5"|"jit"|"jit52")
) ->  Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
}
```

The tree in which to install rocks.
If installing packages for a project, use `project:tree(config)` instead

#### Config.variables
---
```lua
function Config.variables(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  { [string]: string }
```

Variable names, mapped to their values.
Lux populates variables in the `lux.toml` and in RockSpecs
with these before building.

#### Config.verbose
---
```lua
function Config.verbose(self: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  boolean
```

Whether to display verbose output of commands executed


## class ConfigBuilder

Incrementally builds a `Config` by layering configuration sources.

---

### methods
---

#### ConfigBuilder.build
---
```lua
function ConfigBuilder.build(self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}) ->  Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
```

#### ConfigBuilder.cache_dir
---
```lua
function ConfigBuilder.cache_dir(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  cache_dir: string?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```

The cache directory, e.g. for luarocks manifests.

#### ConfigBuilder.data_dir
---
```lua
function ConfigBuilder.data_dir(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  data_dir: string?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```

The data directory, in which the default user install tree resides.

#### ConfigBuilder.dev
---
```lua
function ConfigBuilder.dev(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  dev: boolean?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `dev` - Default: false

Whether to development packages

#### ConfigBuilder.entrypoint_layout
---
```lua
function ConfigBuilder.entrypoint_layout(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  layout: RockLayoutConfig?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```

The rock layout for entrypoints of new install trees.
Does not affect existing install trees or dependency rock layouts.

#### ConfigBuilder.extra_servers
---
```lua
function ConfigBuilder.extra_servers(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  servers: string[]?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `servers` - List of server URLs

Fetch rocks/rockspecs from these servers in addition to the main server

#### ConfigBuilder.generate_luarc
---
```lua
function ConfigBuilder.generate_luarc(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  generate: boolean?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `generate` - Default: true

Whether to generate a `.luarc.json` on build.

#### ConfigBuilder.lua_dir
---
```lua
function ConfigBuilder.lua_dir(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  lua_dir: (string|nil<path>)
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```

Specify the directory in which to install Lua if not found

#### ConfigBuilder.lua_version
---
```lua
function ConfigBuilder.lua_version(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  lua_version: ("5.1"|"5.2"|"5.3"|"5.4"|"5.5"|"jit"|"jit52")?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `lua_version` - Default: The installed Lua version, if detected

Which Lua version to use

#### ConfigBuilder.namespace
---
```lua
function ConfigBuilder.namespace(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  namespace: string?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```

Specify the luarocks server namespace to use

#### ConfigBuilder.no_progress
---
```lua
function ConfigBuilder.no_progress(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  no_progress: boolean?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `no_progress` - Default: false

Whether to disable printing progress bars and spinners

#### ConfigBuilder.no_prompt
---
```lua
function ConfigBuilder.no_prompt(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  no_progress: boolean?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `no_progress` - Default: false

Whether to disable user prompts

#### ConfigBuilder.server
---
```lua
function ConfigBuilder.server(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  server: string?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `server` - Default: 'https://luarocks.org/'

Fetch rocks/rockspecs from this luarocks server

#### ConfigBuilder.timeout
---
```lua
function ConfigBuilder.timeout(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  timeout: integer?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `timeout` - Default: 30 s

Timeout on network operations, in seconds.
0 means no timeout (wait forever).

#### ConfigBuilder.user_agent
---
```lua
function ConfigBuilder.user_agent(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  user_agent: string?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `user_agent` - Default: 'lux-lua/&lt;version&gt;'

The user agent to set when making web requests.

#### ConfigBuilder.user_tree
---
```lua
function ConfigBuilder.user_tree(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  tree: string?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `tree` - Tree root directory

Which tree to operate on

#### ConfigBuilder.verbose
---
```lua
function ConfigBuilder.verbose(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  verbose: boolean?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `verbose` - Default: false

Whether to display verbose output of commands executed

#### ConfigBuilder.wrap_bin_scripts
---
```lua
function ConfigBuilder.wrap_bin_scripts(
  self: ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
},
  wrap: boolean?
) ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```
@param `wrap` - Default: true

Whether to wrap installed Lua bin scripts to be executed with
the detected or configured Lua installation.
Setting this to `false` disables wrapping globally.
If set to `true`, individual rocks can still disable wrapping of their own bin scripts.


## class ConfigModule

Module for building a Lux `Config`

---

### methods
---

#### ConfigModule.builder
---
```lua
function ConfigModule.builder() ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```

Create a new config builder, starting with a blank slate

#### ConfigModule.default
---
```lua
function ConfigModule.default() ->  Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
```

Create a config builder that builds the default `Config`

#### ConfigModule.new
---
```lua
function ConfigModule.new() ->  ConfigBuilder {
    build = function,
    cache_dir = function,
    data_dir = function,
    dev = function,
    entrypoint_layout = function,
    extra_servers = function,
    generate_luarc = function,
    lua_dir = function,
    lua_version = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_agent = function,
    user_tree = function,
    verbose = function,
    wrap_bin_scripts = function,
}
```

Create a new config builder by deserializing from a config file
if present, or otherwise by instantiating the default config


## class DownloadedRockspec

Remote Lua RockSpec that has been downloaded from a remote server, along with its source metadata

---

### methods
---

#### DownloadedRockspec.rockspec
---
```lua
function DownloadedRockspec.rockspec(self: DownloadedRockspec {
    rockspec = function,
}) ->  RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}
```


## class GitSource

Specifies a source to be fetched from a git forge

---

### methods
---

#### GitSource.checkout_ref
---
```lua
function GitSource.checkout_ref(self: GitSource {
    checkout_ref = function,
    url = function,
}) ->  string?
```

#### GitSource.url
---
```lua
function GitSource.url(self: GitSource {
    checkout_ref = function,
    url = function,
}) ->  string
```


## class InstallSpec

For packages which don't provide means to install modules
and expect the user to copy the .lua or library files by hand to the proper locations.
This struct contains categories of files. Each category is itself a table,
where the array part is a list of filenames to be copied.
For module directories only, in the hash part, other keys are identifiers in Lua module format,
to indicate which subdirectory the file should be copied to.
For example, lua = &#123;["foo.bar"] = "src/bar.lua"&#125; will copy src/bar.lua
to the foo directory under the rock's Lua files directory.

---

### methods
---

#### InstallSpec.bin
---
```lua
function InstallSpec.bin(self: InstallSpec {
    bin = function,
    conf = function,
    lib = function,
    lua = function,
}) ->  { [string]: string }
```

Lua command-line scripts

#### InstallSpec.conf
---
```lua
function InstallSpec.conf(self: InstallSpec {
    bin = function,
    conf = function,
    lib = function,
    lua = function,
}) ->  { [string]: string }
```

Configuration files

#### InstallSpec.lib
---
```lua
function InstallSpec.lib(self: InstallSpec {
    bin = function,
    conf = function,
    lib = function,
    lua = function,
}) ->  { [string]: string }
```

Dynamic libraries implemented compiled Lua modules

#### InstallSpec.lua
---
```lua
function InstallSpec.lua(self: InstallSpec {
    bin = function,
    conf = function,
    lib = function,
    lua = function,
}) ->  { [string]: string }
```

Lua modules written in Lua


## class LocalLuaRockspec

RockSpec for a local rock installation, deserialized from a `.rockspec` file

---

### methods
---

#### LocalLuaRockspec.build
---
```lua
function LocalLuaRockspec.build(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  BuildSpec {
    build_backend = function,
    copy_directories = function,
    install = function,
    patches = function,
}
```

#### LocalLuaRockspec.build_dependencies
---
```lua
function LocalLuaRockspec.build_dependencies(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### LocalLuaRockspec.dependencies
---
```lua
function LocalLuaRockspec.dependencies(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### LocalLuaRockspec.description
---
```lua
function LocalLuaRockspec.description(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}
```

#### LocalLuaRockspec.external_dependencies
---
```lua
function LocalLuaRockspec.external_dependencies(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  { [string]: table }
```

#### LocalLuaRockspec.format
---
```lua
function LocalLuaRockspec.format(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string?
```

#### LocalLuaRockspec.lua
---
```lua
function LocalLuaRockspec.lua(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### LocalLuaRockspec.package
---
```lua
function LocalLuaRockspec.package(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### LocalLuaRockspec.source
---
```lua
function LocalLuaRockspec.source(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  RemoteRockSource {
    archive_name = function,
    source_spec = function,
    unpack_dir = function,
}
```

#### LocalLuaRockspec.supported_platforms
---
```lua
function LocalLuaRockspec.supported_platforms(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  PlatformSupport {
    is_supported = function,
}
```

#### LocalLuaRockspec.test
---
```lua
function LocalLuaRockspec.test(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  table
```

#### LocalLuaRockspec.test_dependencies
---
```lua
function LocalLuaRockspec.test_dependencies(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### LocalLuaRockspec.to_lua_rockspec_string
---
```lua
function LocalLuaRockspec.to_lua_rockspec_string(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### LocalLuaRockspec.version
---
```lua
function LocalLuaRockspec.version(self: LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```


## class LocalPackage

A locally installed rock

---

### methods
---

#### LocalPackage.constraint
---
```lua
function LocalPackage.constraint(self: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}) ->  string
```

#### LocalPackage.dependencies
---
```lua
function LocalPackage.dependencies(self: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}) ->  string[]
```

#### LocalPackage.hashes
---
```lua
function LocalPackage.hashes(self: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}) ->  LocalPackageHashes {
    rockspec = function,
    source = function,
}
```

#### LocalPackage.id
---
```lua
function LocalPackage.id(self: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}) ->  string
```

#### LocalPackage.name
---
```lua
function LocalPackage.name(self: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}) ->  string
```

#### LocalPackage.pinned
---
```lua
function LocalPackage.pinned(self: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}) ->  boolean
```

#### LocalPackage.to_package
---
```lua
function LocalPackage.to_package(self: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}) ->  PackageSpec {
    name = string,
    version = string,
    to_package_req = function,
}
```

#### LocalPackage.to_package_req
---
```lua
function LocalPackage.to_package_req(self: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}) ->  PackageReq {
    matches = function,
    name = function,
    version_req = function,
}
```

#### LocalPackage.version
---
```lua
function LocalPackage.version(self: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}) ->  string
```


## class LocalPackageHashes

Rockspec and source integrities of an installed rock

---

### methods
---

#### LocalPackageHashes.rockspec
---
```lua
function LocalPackageHashes.rockspec(self: LocalPackageHashes {
    rockspec = function,
    source = function,
}) ->  string
```

#### LocalPackageHashes.source
---
```lua
function LocalPackageHashes.source(self: LocalPackageHashes {
    rockspec = function,
    source = function,
}) ->  string
```


## class LocalProjectToml

The `lux.toml` file, after being properly deserialized.
This struct may be used to build a local version of a project.
To build a rockspec, use `RemoteProjectToml`.

---

### methods
---

#### LocalProjectToml.build
---
```lua
function LocalProjectToml.build(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  BuildSpec {
    build_backend = function,
    copy_directories = function,
    install = function,
    patches = function,
}
```

#### LocalProjectToml.build_dependencies
---
```lua
function LocalProjectToml.build_dependencies(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### LocalProjectToml.dependencies
---
```lua
function LocalProjectToml.dependencies(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### LocalProjectToml.description
---
```lua
function LocalProjectToml.description(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}
```

#### LocalProjectToml.package
---
```lua
function LocalProjectToml.package(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### LocalProjectToml.test
---
```lua
function LocalProjectToml.test(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  table
```

#### LocalProjectToml.test_dependencies
---
```lua
function LocalProjectToml.test_dependencies(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### LocalProjectToml.to_lua_rockspec
---
```lua
function LocalProjectToml.to_lua_rockspec(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}
```

#### LocalProjectToml.to_lua_rockspec_string
---
```lua
function LocalProjectToml.to_lua_rockspec_string(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### LocalProjectToml.version
---
```lua
function LocalProjectToml.version(self: LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```


## class LockfileGuard

Flushes a lockfile automatically when it goes out of scope

---

### methods
---

#### LockfileGuard.get
---
```lua
function LockfileGuard.get(
  self: LockfileGuard {
    get = function,
    rocks = function,
    version = function,
},
  id: string
) ->  LocalPackage?
```

#### LockfileGuard.rocks
---
```lua
function LockfileGuard.rocks(self: LockfileGuard {
    get = function,
    rocks = function,
    version = function,
}) ->  { [string]: LocalPackage }
```

#### LockfileGuard.version
---
```lua
function LockfileGuard.version(self: LockfileGuard {
    get = function,
    rocks = function,
    version = function,
}) ->  string
```


## class LockfileReadOnly

Read-only lockfile for an install tree

---

### methods
---

#### LockfileReadOnly.get
---
```lua
function LockfileReadOnly.get(
  self: LockfileReadOnly {
    get = function,
    map_then_flush = function,
    rocks = function,
    version = function,
},
  id: string
) ->  LocalPackage?
```

#### LockfileReadOnly.map_then_flush
---
```lua
function LockfileReadOnly.map_then_flush(
  self: LockfileReadOnly {
    get = function,
    map_then_flush = function,
    rocks = function,
    version = function,
},
  f: fun()
)
```
@param `f` - Takes the writable lockfile

Converts the current lockfile into a writeable one, executes `f` and flushes

#### LockfileReadOnly.rocks
---
```lua
function LockfileReadOnly.rocks(self: LockfileReadOnly {
    get = function,
    map_then_flush = function,
    rocks = function,
    version = function,
}) ->  { [string]: LocalPackage }
```

#### LockfileReadOnly.version
---
```lua
function LockfileReadOnly.version(self: LockfileReadOnly {
    get = function,
    map_then_flush = function,
    rocks = function,
    version = function,
}) ->  string
```


## class LockfileReadWrite

Writable lockfile for an install tree

---

### methods
---

#### LockfileReadWrite.get
---
```lua
function LockfileReadWrite.get(
  self: LockfileReadWrite {
    get = function,
    rocks = function,
    version = function,
},
  id: string
) ->  LocalPackage?
```

#### LockfileReadWrite.rocks
---
```lua
function LockfileReadWrite.rocks(self: LockfileReadWrite {
    get = function,
    rocks = function,
    version = function,
}) ->  { [string]: LocalPackage }
```

#### LockfileReadWrite.version
---
```lua
function LockfileReadWrite.version(self: LockfileReadWrite {
    get = function,
    rocks = function,
    version = function,
}) ->  string
```


## class LuaDependencySpec

Specification for a Lua dependency in a Lux project

---

### methods
---

#### LuaDependencySpec.matches
---
```lua
function LuaDependencySpec.matches(
  self: LuaDependencySpec {
    matches = function,
    name = function,
    package_req = function,
    version_req = function,
},
  package: PackageSpec {
    name = string,
    version = string,
    to_package_req = function,
}
) ->  boolean
```
@param `package` - package spec to check

Evaluate whether the given package satisfies this dependency's requirement.

#### LuaDependencySpec.name
---
```lua
function LuaDependencySpec.name(self: LuaDependencySpec {
    matches = function,
    name = function,
    package_req = function,
    version_req = function,
}) ->  string
```

#### LuaDependencySpec.package_req
---
```lua
function LuaDependencySpec.package_req(self: LuaDependencySpec {
    matches = function,
    name = function,
    package_req = function,
    version_req = function,
}) ->  PackageReq {
    matches = function,
    name = function,
    version_req = function,
}
```

#### LuaDependencySpec.version_req
---
```lua
function LuaDependencySpec.version_req(self: LuaDependencySpec {
    matches = function,
    name = function,
    package_req = function,
    version_req = function,
}) ->  string
```


## class LuaScriptTestSpec

Specification for running a test suite with a Lua script

---

### methods
---

#### LuaScriptTestSpec.flags
---
```lua
function LuaScriptTestSpec.flags(self: LuaScriptTestSpec {
    flags = function,
    script = function,
}) ->  string[]
```

Additional CLI flags to pass to the script when running

#### LuaScriptTestSpec.script
---
```lua
function LuaScriptTestSpec.script(self: LuaScriptTestSpec {
    flags = function,
    script = function,
}) ->  string
```

The script to run


## class MakeBuildSpec

Specification for building a rock with the `make` build backend

---

### methods
---

#### MakeBuildSpec.build_pass
---
```lua
function MakeBuildSpec.build_pass(self: MakeBuildSpec {
    build_pass = function,
    build_target = function,
    build_variables = function,
    install_pass = function,
    install_target = function,
    install_variables = function,
    makefile = function,
    variables = function,
}) ->  boolean
```

Whether to perform a make pass on the target indicated by `build_target`

#### MakeBuildSpec.build_target
---
```lua
function MakeBuildSpec.build_target(self: MakeBuildSpec {
    build_pass = function,
    build_target = function,
    build_variables = function,
    install_pass = function,
    install_target = function,
    install_variables = function,
    makefile = function,
    variables = function,
}) ->  string?
```

#### MakeBuildSpec.build_variables
---
```lua
function MakeBuildSpec.build_variables(self: MakeBuildSpec {
    build_pass = function,
    build_target = function,
    build_variables = function,
    install_pass = function,
    install_target = function,
    install_variables = function,
    makefile = function,
    variables = function,
}) ->  { [string]: string }
```

Assignments to be passed to make during the build pass

#### MakeBuildSpec.install_pass
---
```lua
function MakeBuildSpec.install_pass(self: MakeBuildSpec {
    build_pass = function,
    build_target = function,
    build_variables = function,
    install_pass = function,
    install_target = function,
    install_variables = function,
    makefile = function,
    variables = function,
}) ->  boolean
```

Whether to perform a make pass on the target indicated by `install_target`

#### MakeBuildSpec.install_target
---
```lua
function MakeBuildSpec.install_target(self: MakeBuildSpec {
    build_pass = function,
    build_target = function,
    build_variables = function,
    install_pass = function,
    install_target = function,
    install_variables = function,
    makefile = function,
    variables = function,
}) ->  string
```

#### MakeBuildSpec.install_variables
---
```lua
function MakeBuildSpec.install_variables(self: MakeBuildSpec {
    build_pass = function,
    build_target = function,
    build_variables = function,
    install_pass = function,
    install_target = function,
    install_variables = function,
    makefile = function,
    variables = function,
}) ->  { [string]: string }
```

Assignments to be passed to make during the install pass

#### MakeBuildSpec.makefile
---
```lua
function MakeBuildSpec.makefile(self: MakeBuildSpec {
    build_pass = function,
    build_target = function,
    build_variables = function,
    install_pass = function,
    install_target = function,
    install_variables = function,
    makefile = function,
    variables = function,
}) ->  string
```

Makefile to be used

#### MakeBuildSpec.variables
---
```lua
function MakeBuildSpec.variables(self: MakeBuildSpec {
    build_pass = function,
    build_target = function,
    build_variables = function,
    install_pass = function,
    install_target = function,
    install_variables = function,
    makefile = function,
    variables = function,
}) ->  { [string]: string }
```

Assignments to be passed to make during both passes


## class ModulePaths

Specification for building a Lua module from various sources

---

### methods
---

#### ModulePaths.defines
---
```lua
function ModulePaths.defines(self: ModulePaths {
    defines = function,
    incdirs = function,
    libdirs = function,
    libraries = function,
    sources = function,
}) ->  { [string]: string? }
```

C defines, e.g. &#123; 'FOO=bar', 'USE_BLA' &#125;

#### ModulePaths.incdirs
---
```lua
function ModulePaths.incdirs(self: ModulePaths {
    defines = function,
    incdirs = function,
    libdirs = function,
    libraries = function,
    sources = function,
}) ->  string[]
```

Directories to be added to the compiler's headers lookup directory list.

#### ModulePaths.libdirs
---
```lua
function ModulePaths.libdirs(self: ModulePaths {
    defines = function,
    incdirs = function,
    libdirs = function,
    libraries = function,
    sources = function,
}) ->  string[]
```

Directories to be added to the linker's library lookup directory list.

#### ModulePaths.libraries
---
```lua
function ModulePaths.libraries(self: ModulePaths {
    defines = function,
    incdirs = function,
    libdirs = function,
    libraries = function,
    sources = function,
}) ->  string[]
```

External libraries to be linked

#### ModulePaths.sources
---
```lua
function ModulePaths.sources(self: ModulePaths {
    defines = function,
    incdirs = function,
    libdirs = function,
    libraries = function,
    sources = function,
}) ->  string[]
```

Path names of C sources, mandatory field


## class OperationsModule

Module for Lux operations

---

### methods
---

#### OperationsModule.build
---
```lua
function OperationsModule.build(
  workspace: Workspace,
  package: string?,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
) ->  LocalPackage[]
```
@param `workspace` - Workspace to build

@param `package` - Build only this package

@param `config` - Lux config

Build a workspace

#### OperationsModule.dist_bin
---
```lua
function OperationsModule.dist_bin(
  project: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
},
  tree: Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
},
  output: string,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
) ->  string
```
@param `project` - Project to compile

@param `tree` - Install tree

@param `output` - Destination path for the compiled binary

@param `config` - Lux config


@return  - 1: the path to the compiled binary

Distribute a project as a single static binary

#### OperationsModule.download_rockspec
---
```lua
function OperationsModule.download_rockspec(
  package_req: string,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
) ->  DownloadedRockspec {
    rockspec = function,
}
```
@param `package_req` - Package to search for, e.g. 'foo' or 'foo &gt;= 1.0.0'

@param `config` - Lux config

Download the RockSpec for a package

#### OperationsModule.install
---
```lua
function OperationsModule.install(
  packages: table[],
  tree: Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
},
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
) ->  LocalPackage[]
```
@param `packages` - List of packages to install

@param `tree` - Install tree

@param `config` - Lux config

Install one or multiple package(s)

#### OperationsModule.pin
---
```lua
function OperationsModule.pin(
  package_id: string,
  tree: Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
},
  pin_state: boolean
)
```
@param `package_id` - ID of the package to pin

@param `tree` - Install tree

@param `pin_state` - The pinned state to set

Set the pinned state of a package

#### OperationsModule.search
---
```lua
function OperationsModule.search(
  query: string,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
) ->  { [string]: string[] }
```
@param `query` - Package to search for, e.g. 'foo' or 'foo &gt;= 1.0.0'

@param `config` - Lux config

Search for a remote package

#### OperationsModule.sync
---
```lua
function OperationsModule.sync(
  workspace: Workspace,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
)
 ->  table
 ->  table
 ->  table

```
@param `workspace` - Workspace to sync

@param `config` - Lux config

Sync all workspace dependencies

#### OperationsModule.sync_build_dependencies
---
```lua
function OperationsModule.sync_build_dependencies(
  workspace: Workspace,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
) ->  table
```
@param `workspace` - Workspace to sync

@param `config` - Lux config

Sync workspace build dependencies

#### OperationsModule.sync_dependencies
---
```lua
function OperationsModule.sync_dependencies(
  workspace: Workspace,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
) ->  table
```
@param `workspace` - Workspace to sync

@param `config` - Lux config

Sync workspace dependencies

#### OperationsModule.sync_test_dependencies
---
```lua
function OperationsModule.sync_test_dependencies(
  workspace: Workspace,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
) ->  table
```
@param `workspace` - Workspace to sync

@param `config` - Lux config

Sync workspace test dependencies

#### OperationsModule.uninstall
---
```lua
function OperationsModule.uninstall(
  packages: string[],
  tree: Tree?,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
)
```
@param `packages` - IDs of packages to uninstall

@param `tree` - Install tree

@param `config` - Lux config

Uninstall one or multiple package(s)

#### OperationsModule.update
---
```lua
function OperationsModule.update(config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}) ->  LocalPackage[]
```
@param `config` - Lux config

Update installed packages


## class PackageReq

A lua package requirement with a name and an optional version requirement

---

### methods
---

#### PackageReq.matches
---
```lua
function PackageReq.matches(
  self: PackageReq {
    matches = function,
    name = function,
    version_req = function,
},
  package: PackageSpec {
    name = string,
    version = string,
    to_package_req = function,
}
) ->  boolean
```
@param `package` - package spec to check

Evaluate whether the given package satisfies this package requirement.

#### PackageReq.name
---
```lua
function PackageReq.name(self: PackageReq {
    matches = function,
    name = function,
    version_req = function,
}) ->  string
```

#### PackageReq.version_req
---
```lua
function PackageReq.version_req(self: PackageReq {
    matches = function,
    name = function,
    version_req = function,
}) ->  string
```


## class PackageSpec

Specification for a package with an exact name and version

---

### methods
---

#### PackageSpec.to_package_req
---
```lua
function PackageSpec.to_package_req(self: PackageSpec {
    name = string,
    version = string,
    to_package_req = function,
}) ->  PackageReq {
    matches = function,
    name = function,
    version_req = function,
}
```

Convert this spec to a package requirement (with an exact version requirement)

### fields
---

#### PackageSpec.name
---
```lua
PackageSpec.name : string
```

#### PackageSpec.version
---
```lua
PackageSpec.version : string
```


## class PartialLuaRockspec

Deserialized from a Lua `.rockspec`, not yet validated

---


## class PartialProjectToml

The `lux.toml` file for a project.
The only required fields are `package` and `build`, which are required to build a project using `lux build`.
The rest of the fields are optional, but are required to build a rockspec.

---

### methods
---

#### PartialProjectToml.package
---
```lua
function PartialProjectToml.package(self: PartialProjectToml {
    package = function,
    to_local = function,
    to_remote = function,
}) ->  string
```

#### PartialProjectToml.to_local
---
```lua
function PartialProjectToml.to_local(self: PartialProjectToml {
    package = function,
    to_local = function,
    to_remote = function,
}) ->  LocalProjectToml {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    package = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}
```

#### PartialProjectToml.to_remote
---
```lua
function PartialProjectToml.to_remote(
  self: PartialProjectToml {
    package = function,
    to_local = function,
    to_remote = function,
},
  specrev: integer?
) ->  RemoteProjectToml {
    build = function,
    dependencies = function,
    description = function,
    package = function,
    source = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}
```
@param `specrev` - The revision of the RockSpec


## class PlatformSupport

Used to specify which platforms a rock can be built for

---

### methods
---

#### PlatformSupport.is_supported
---
```lua
function PlatformSupport.is_supported(
  self: PlatformSupport {
    is_supported = function,
},
  platform: unknown
) ->  boolean
```

Is the given platform supported?


## class Project

Lux project, with methods for managing dependencies, etc.

---

### methods
---

#### Project.add
---
```lua
function Project.add(
  self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
},
  deps: table,
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
)
```
@param `deps` - Dependencies to add

@param `config` - Lux config

#### Project.extra_rockspec
---
```lua
function Project.extra_rockspec(self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
}) ->  PartialLuaRockspec?
```

#### Project.extra_rockspec_path
---
```lua
function Project.extra_rockspec_path(self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
}) ->  string
```

#### Project.local_rockspec
---
```lua
function Project.local_rockspec(self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
}) ->  LocalLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}
```

#### Project.lua_version
---
```lua
function Project.lua_version(
  self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
},
  config: Config {
    builder = function,
    cache_dir = function,
    cmake_cmd = function,
    data_dir = function,
    enabled_dev_servers = function,
    entrypoint_layout = function,
    extra_servers = function,
    lua_dir = function,
    make_cmd = function,
    namespace = function,
    no_progress = function,
    no_prompt = function,
    server = function,
    timeout = function,
    user_tree = function,
    variables = function,
    verbose = function,
}
) ->  string
```
@param `config` - Lux config

#### Project.project_files
---
```lua
function Project.project_files(self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
}) ->  string[]
```

#### Project.remote_rockspec
---
```lua
function Project.remote_rockspec(
  self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
},
  specrev: integer?
) ->  RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}
```
@param `specrev` - The revision of the RockSpec

#### Project.remove
---
```lua
function Project.remove(
  self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
},
  deps: table
)
```
@param `deps` - Dependencies to remove

#### Project.root
---
```lua
function Project.root(self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
}) ->  string
```

#### Project.toml
---
```lua
function Project.toml(self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
}) ->  PartialProjectToml {
    package = function,
    to_local = function,
    to_remote = function,
}
```

#### Project.toml_path
---
```lua
function Project.toml_path(self: Project {
    add = function,
    extra_rockspec = function,
    extra_rockspec_path = function,
    local_rockspec = function,
    lua_version = function,
    project_files = function,
    remote_rockspec = function,
    remove = function,
    root = function,
    toml = function,
    toml_path = function,
}) ->  string
```


## class ProjectModule

Module for interacting with a Lux project

---

### methods
---

#### ProjectModule.new
---
```lua
function ProjectModule.new(path: string) ->  Project?
```
@param `path` - project root

Load a project at the specified path, if it exists


## class RemoteLuaRockspec

RockSpec for a remote rock, deserialized from a `.rockspec` file

---

### methods
---

#### RemoteLuaRockspec.build
---
```lua
function RemoteLuaRockspec.build(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  BuildSpec {
    build_backend = function,
    copy_directories = function,
    install = function,
    patches = function,
}
```

#### RemoteLuaRockspec.build_dependencies
---
```lua
function RemoteLuaRockspec.build_dependencies(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### RemoteLuaRockspec.dependencies
---
```lua
function RemoteLuaRockspec.dependencies(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### RemoteLuaRockspec.description
---
```lua
function RemoteLuaRockspec.description(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}
```

#### RemoteLuaRockspec.external_dependencies
---
```lua
function RemoteLuaRockspec.external_dependencies(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  { [string]: table }
```

#### RemoteLuaRockspec.format
---
```lua
function RemoteLuaRockspec.format(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string?
```

#### RemoteLuaRockspec.lua
---
```lua
function RemoteLuaRockspec.lua(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### RemoteLuaRockspec.package
---
```lua
function RemoteLuaRockspec.package(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### RemoteLuaRockspec.source
---
```lua
function RemoteLuaRockspec.source(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  RemoteRockSource {
    archive_name = function,
    source_spec = function,
    unpack_dir = function,
}
```

#### RemoteLuaRockspec.supported_platforms
---
```lua
function RemoteLuaRockspec.supported_platforms(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  PlatformSupport {
    is_supported = function,
}
```

#### RemoteLuaRockspec.test
---
```lua
function RemoteLuaRockspec.test(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  table
```

#### RemoteLuaRockspec.test_dependencies
---
```lua
function RemoteLuaRockspec.test_dependencies(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### RemoteLuaRockspec.to_lua_rockspec_string
---
```lua
function RemoteLuaRockspec.to_lua_rockspec_string(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### RemoteLuaRockspec.version
---
```lua
function RemoteLuaRockspec.version(self: RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```


## class RemotePackageDB

Package database, used to look up remote rocks

---

### methods
---

#### RemotePackageDB.latest_match
---
```lua
function RemotePackageDB.latest_match(
  self: RemotePackageDB {
    latest_match = function,
    search = function,
},
  package_req: PackageReq {
    matches = function,
    name = function,
    version_req = function,
}
) ->  PackageSpec?
```
@param `package_req` - Package to search for, e.g. 'foo' or 'foo &gt;= 1.0.0'

Find the latest package that matches the requirement.

#### RemotePackageDB.search
---
```lua
function RemotePackageDB.search(
  self: RemotePackageDB {
    latest_match = function,
    search = function,
},
  package_req: PackageReq {
    matches = function,
    name = function,
    version_req = function,
}
) ->  { [string]: string[] }
```
@param `package_req` - Package to search for, e.g. 'foo' or 'foo &gt;= 1.0.0'

Search for all packages that match the requirement


## class RemoteProjectToml

The `lux.toml`, after being validated and prepared for upload

---

### methods
---

#### RemoteProjectToml.build
---
```lua
function RemoteProjectToml.build(self: RemoteProjectToml {
    build = function,
    dependencies = function,
    description = function,
    package = function,
    source = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  BuildSpec {
    build_backend = function,
    copy_directories = function,
    install = function,
    patches = function,
}
```

#### RemoteProjectToml.dependencies
---
```lua
function RemoteProjectToml.dependencies(self: RemoteProjectToml {
    build = function,
    dependencies = function,
    description = function,
    package = function,
    source = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  LuaDependencySpec[]
```

#### RemoteProjectToml.description
---
```lua
function RemoteProjectToml.description(self: RemoteProjectToml {
    build = function,
    dependencies = function,
    description = function,
    package = function,
    source = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}
```

#### RemoteProjectToml.package
---
```lua
function RemoteProjectToml.package(self: RemoteProjectToml {
    build = function,
    dependencies = function,
    description = function,
    package = function,
    source = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### RemoteProjectToml.source
---
```lua
function RemoteProjectToml.source(self: RemoteProjectToml {
    build = function,
    dependencies = function,
    description = function,
    package = function,
    source = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  RemoteRockSource {
    archive_name = function,
    source_spec = function,
    unpack_dir = function,
}
```

#### RemoteProjectToml.to_lua_rockspec
---
```lua
function RemoteProjectToml.to_lua_rockspec(self: RemoteProjectToml {
    build = function,
    dependencies = function,
    description = function,
    package = function,
    source = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  RemoteLuaRockspec {
    build = function,
    build_dependencies = function,
    dependencies = function,
    description = function,
    external_dependencies = function,
    format = function,
    lua = function,
    package = function,
    source = function,
    supported_platforms = function,
    test = function,
    test_dependencies = function,
    to_lua_rockspec_string = function,
    version = function,
}
```

#### RemoteProjectToml.to_lua_rockspec_string
---
```lua
function RemoteProjectToml.to_lua_rockspec_string(self: RemoteProjectToml {
    build = function,
    dependencies = function,
    description = function,
    package = function,
    source = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```

#### RemoteProjectToml.version
---
```lua
function RemoteProjectToml.version(self: RemoteProjectToml {
    build = function,
    dependencies = function,
    description = function,
    package = function,
    source = function,
    to_lua_rockspec = function,
    to_lua_rockspec_string = function,
    version = function,
}) ->  string
```


## class RemoteRockSource

Specifies the source of a remote rock to be fetched

---

### methods
---

#### RemoteRockSource.archive_name
---
```lua
function RemoteRockSource.archive_name(self: RemoteRockSource {
    archive_name = function,
    source_spec = function,
    unpack_dir = function,
}) ->  string?
```

#### RemoteRockSource.source_spec
---
```lua
function RemoteRockSource.source_spec(self: RemoteRockSource {
    archive_name = function,
    source_spec = function,
    unpack_dir = function,
}) ->  table
```

#### RemoteRockSource.unpack_dir
---
```lua
function RemoteRockSource.unpack_dir(self: RemoteRockSource {
    archive_name = function,
    source_spec = function,
    unpack_dir = function,
}) ->  string?
```


## class RockDescription

A rock's metadata, to be displayed on the remote package server

---

### methods
---

#### RockDescription.detailed
---
```lua
function RockDescription.detailed(self: RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}) ->  string?
```

A longer description of the package

#### RockDescription.homepage
---
```lua
function RockDescription.homepage(self: RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}) ->  string?
```

An URL for the project. This is not the URL for the tarball, but the address of a website

#### RockDescription.issues_url
---
```lua
function RockDescription.issues_url(self: RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}) ->  string?
```

An URL for the project's issue tracker

#### RockDescription.labels
---
```lua
function RockDescription.labels(self: RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}) ->  string[]
```

A list of short strings that specify labels for categorization of this rock

#### RockDescription.license
---
```lua
function RockDescription.license(self: RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}) ->  string?
```

The license used by the package

#### RockDescription.maintainer
---
```lua
function RockDescription.maintainer(self: RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}) ->  string?
```

Contact information for the rockspec maintainer

#### RockDescription.summary
---
```lua
function RockDescription.summary(self: RockDescription {
    detailed = function,
    homepage = function,
    issues_url = function,
    labels = function,
    license = function,
    maintainer = function,
    summary = function,
}) ->  string?
```

A one-line description of the package


## class RockLayout

Change-agnostic way of referencing various paths for a rock

---

### fields
---

#### RockLayout.bin
---
```lua
RockLayout.bin : string
```

#### RockLayout.conf
---
```lua
RockLayout.conf : string
```

#### RockLayout.doc
---
```lua
RockLayout.doc : string
```

#### RockLayout.etc
---
```lua
RockLayout.etc : string
```

#### RockLayout.lib
---
```lua
RockLayout.lib : string
```

#### RockLayout.rock_path
---
```lua
RockLayout.rock_path : string
```

#### RockLayout.src
---
```lua
RockLayout.src : string
```


## class RockLayoutConfig

Template configuration for a rock's tree layout

---

### methods
---

#### RockLayoutConfig.new
---
```lua
function RockLayoutConfig.new() ->  RockLayoutConfig {
    new = function,
    new_nvim_layout = function,
}
```

Instantiate the default rock layout

#### RockLayoutConfig.new_nvim_layout
---
```lua
function RockLayoutConfig.new_nvim_layout() ->  RockLayoutConfig {
    new = function,
    new_nvim_layout = function,
}
```

Instantiate the a rock layout for Neovim plugins


## class RustMluaBuildSpec

Specification for building a rock with the `rust-mlua` build backend

---

### methods
---

#### RustMluaBuildSpec.cargo_extra_args
---
```lua
function RustMluaBuildSpec.cargo_extra_args(self: RustMluaBuildSpec {
    cargo_extra_args = function,
    default_features = function,
    features = function,
    include = function,
    modules = function,
    target_path = function,
}) ->  string[]
```

Additional flags to be passed in the cargo invocation

#### RustMluaBuildSpec.default_features
---
```lua
function RustMluaBuildSpec.default_features(self: RustMluaBuildSpec {
    cargo_extra_args = function,
    default_features = function,
    features = function,
    include = function,
    modules = function,
    target_path = function,
}) ->  boolean
```

If set to `false` pass `--no-default-features` to cargo.

#### RustMluaBuildSpec.features
---
```lua
function RustMluaBuildSpec.features(self: RustMluaBuildSpec {
    cargo_extra_args = function,
    default_features = function,
    features = function,
    include = function,
    modules = function,
    target_path = function,
}) ->  string[]
```

Pass additional features

#### RustMluaBuildSpec.include
---
```lua
function RustMluaBuildSpec.include(self: RustMluaBuildSpec {
    cargo_extra_args = function,
    default_features = function,
    features = function,
    include = function,
    modules = function,
    target_path = function,
}) ->  { [string]: string }
```

Copy additional files to the `lua` directory.
Keys are the sources, values the destinations (relative to the `lua` directory).

#### RustMluaBuildSpec.modules
---
```lua
function RustMluaBuildSpec.modules(self: RustMluaBuildSpec {
    cargo_extra_args = function,
    default_features = function,
    features = function,
    include = function,
    modules = function,
    target_path = function,
}) ->  { [string]: string }
```

Keys are module names in the format normally used by the `require()` function.
values are the library names in the target directory (without the `lib` prefix).

#### RustMluaBuildSpec.target_path
---
```lua
function RustMluaBuildSpec.target_path(self: RustMluaBuildSpec {
    cargo_extra_args = function,
    default_features = function,
    features = function,
    include = function,
    modules = function,
    target_path = function,
}) ->  string
```

Set if the cargo `target` directory is not in the source root


## class Tree

A collection of files where installed rocks are located

---

### methods
---

#### Tree.bin
---
```lua
function Tree.bin(self: Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
}) ->  string
```

Where wrapped package binaries are installed

#### Tree.lockfile
---
```lua
function Tree.lockfile(self: Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
}) ->  LockfileReadOnly {
    get = function,
    map_then_flush = function,
    rocks = function,
    version = function,
}
```

Create a `LockfileReadOnly` for this tree.

#### Tree.match_rocks
---
```lua
function Tree.match_rocks(
  self: Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
},
  req: PackageReq {
    matches = function,
    name = function,
    version_req = function,
}
) ->  any
```

Find installed rocks that match the given `PackageReq`

#### Tree.rock_layout
---
```lua
function Tree.rock_layout(
  self: Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
},
  package: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}
) ->  RockLayout {
    bin = string,
    conf = string,
    doc = string,
    etc = string,
    lib = string,
    rock_path = string,
    src = string,
}
```

Get the `RockLayout` for an installed package.

#### Tree.root
---
```lua
function Tree.root(self: Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
}) ->  string
```

The root directory of the tree

#### Tree.root_for
---
```lua
function Tree.root_for(
  self: Tree {
    bin = function,
    lockfile = function,
    match_rocks = function,
    rock_layout = function,
    root = function,
    root_for = function,
},
  package: LocalPackage {
    constraint = function,
    dependencies = function,
    hashes = function,
    id = function,
    name = function,
    pinned = function,
    to_package = function,
    to_package_req = function,
    version = function,
}
) ->  string
```

The root directory of a package in this tree


## class TreesitterParserBuildSpec

Specification for building a rock with the `treesitter-parser` build backend

---

### methods
---

#### TreesitterParserBuildSpec.generate
---
```lua
function TreesitterParserBuildSpec.generate(self: TreesitterParserBuildSpec {
    generate = function,
    lang = function,
    location = function,
    parser = function,
    queries = function,
}) ->  boolean
```

Must the sources be generated?

#### TreesitterParserBuildSpec.lang
---
```lua
function TreesitterParserBuildSpec.lang(self: TreesitterParserBuildSpec {
    generate = function,
    lang = function,
    location = function,
    parser = function,
    queries = function,
}) ->  string
```

Name of the parser language, e.g. 'haskell'

#### TreesitterParserBuildSpec.location
---
```lua
function TreesitterParserBuildSpec.location(self: TreesitterParserBuildSpec {
    generate = function,
    lang = function,
    location = function,
    parser = function,
    queries = function,
}) ->  string?
```

tree-sitter grammar's location (relative to the source root)

#### TreesitterParserBuildSpec.parser
---
```lua
function TreesitterParserBuildSpec.parser(self: TreesitterParserBuildSpec {
    generate = function,
    lang = function,
    location = function,
    parser = function,
    queries = function,
}) ->  boolean
```

Won't build the parser if `false`

#### TreesitterParserBuildSpec.queries
---
```lua
function TreesitterParserBuildSpec.queries(self: TreesitterParserBuildSpec {
    generate = function,
    lang = function,
    location = function,
    parser = function,
    queries = function,
}) ->  { [string]: string }
```

Embedded queries to be installed in the `etc/queries` directory


## class WorkspaceModule

Module for interacting with a Lux workspace

---

### methods
---

#### WorkspaceModule.current
---
```lua
function WorkspaceModule.current() ->  Workspace?
```

Load the current workspace, if in a workspace

#### WorkspaceModule.new
---
```lua
function WorkspaceModule.new(path: string) ->  Workspace?
```
@param `path` - The workspace root

Load the workspace in the given directory, if present

#### WorkspaceModule.new_fuzzy
---
```lua
function WorkspaceModule.new_fuzzy(path: string) ->  Workspace?
```
@param `path` - The directory to search upwards from

Search for a workspace upwards from the given directory and load it, if present


