---
id: cli
title: CLI reference
---

<!-- This file is auto-generated from the man page. Do not edit manually. -->
<!-- Regenerate with: scripts/src/generate-cli-reference.lua -->

# CLI reference (lux-cli 0.35.3)

## Global options

- `--dev` — Enable the sub-repositories in luarocks servers for rockspecs of in-development versions
- `--server <server>` — Fetch rocks/rockspecs from this server (takes priority over config file)
- `--extra-servers <extra-server>` — Fetch rocks/rockspecs from these servers in addition to the main server (overrides any entries in the config file)
- `--namespace <namespace>` — Specify the luarocks server namespace to use
- `--lua-dir <prefix>` — Specify the directory in which to install Lua if not found
- `--lua-version <ver>` — Which Lua installation to use. Valid versions are: '5.1', '5.2', '5.3', '5.4', 'jit' and 'jit52'
- `--tree <tree>` — Which tree to operate on
- `--cache-dir <cache-dir>` — Specifies the cache directory, e.g. for luarocks manifests
- `--data-dir <data-dir>` — Specifies the data directory, in which the default user install tree resides (e.g. ~/.local/share/lux)
- `--vendor-dir <vendor-dir>` — Specifies a directory with locally vendored sources and Rock Specs. When building or installing a package with this flag, Lux will fetch sources from the &lt;vendor-dir&gt; instead of from a re mote server
- `--variables <variable>` — Override config variables. Example: `lx -v "LUA=/path/to/lua" ...`
- `--verbose` — Display verbose output of commands executed
- `--no-progress` — Don't print any progress bars or spinners
- `--no-prompt` — Skip prompts, selecting the default option
- `--nvim` — Configure lux for installing Neovim packages
- `--timeout <seconds>` — Timeout on network operations, in seconds. 0 means no timeout (wait forever). Default is 30
- `--max-jobs <MAX_JOBS>` — Maximum buffer size for parallel jobs, such as downloading rockspecs and installing rocks. 0 means no limit. Default is 0
- `--no-luarc` — Do not generate or update a `.luarc.json` file when building a project
- `--no-wrap-bin` — Do not wrap Lua `bin` scripts
- `--user-agent <USER_AGENT>` — The user agent to set when making web requests. Default is "lux/&lt;version&gt;"
- `-h, --help` — Print help
- `-V, --version` — Print version

## Subcommands

### `lx add`

Add a dependency to the current project

**Usage:** `lx add [OPTIONS] [PACKAGE_REQ]...`

#### Arguments

```
  [PACKAGE_REQ]...  Package or list of packages to install and add to the project's dependencies. 
                     Examples: "pkg", "pkg@1.0.0", "pkg>=1.0.0" 
                     If you do not specify a version requirement, lux will fetch the latest version.
                     
                     
                     You can also specify git packages by providing a git URL shorthand. 
                     Example: "github:owner/repo" 
                     Supported git host prefixes are: "github:", "gitlab:", "sourcehut:" and
                     "codeberg:". 
                     Lux will automatically fetch the latest SemVer tag or commit SHA if no SemVer
                     tag is found. 
                     Note that projects with git dependencies cannot be published to luarocks.org

```

#### Options

- `--force` — Reinstall without prompt if a package is already installed [aliases: -f]
- `-b, --build <BUILD>` — Install the package as a development dependency. Also called `dev` [aliases: -d, -b]
- `-t, --test <TEST>` — Install the package as a test dependency [aliases: -t]
- `-p, --package <PACKAGE>` — Project to modify [aliases: -p]
- `-h, --help` — Print help

### `lx build`

Build/compile a project

**Usage:** `lx build [OPTIONS]`

#### Options

- `--no-lock` — Ignore the project's lockfile and don't create one
- `--only-deps` — Build only the dependencies
- `-p, --package <PACKAGE>` — Package to build [aliases: -p]
- `-h, --help` — Print help

### `lx check`

[EXPERIMENTAL]
 Type check the current project based on EmmyLua/LuaCATS annotations.
 Respects `.emmyrc.json` and `.luarc.json` files in the project directory

**Usage:** `lx check [OPTIONS]`

#### Options

- `-i, --ignore <IGNORE>` — Comma-separated list of ignore patterns. Patterns must follow glob syntax. Lux will automatically add top-level ignored project files
- `--output-format <OUTPUT_FORMAT>` — The output format [default: `text`] [possible values: `json, text`]
- `--output <OUTPUT>` — Output destination. (stdout or a file path, only used when the output format is json) [default: `stdout`]
- `--warnings-as-errors` — Treat warnings as errors
- `-h, --help` — Print help

### `lx config`

Interact with the lux configuration

**Usage:** `lx config <COMMAND>`

#### Subcommands

- `init` — Initialise a new config file
- `edit` — Edit the current config file
- `show` — Show the current config. This includes options picked up from CLI flags
- `help` — Print this message or the help of the given subcommand(s)

#### Options

- `-h, --help` — Print help

### `lx completion`

Generate autocompletion scripts for the shell.
 Example: `lx completion zsh &gt; ~/.zsh/completions/_lx`

**Usage:** `lx completion [SHELL]`

#### Arguments

```
  [SHELL]  The shell to generate the completion script for.
            If not set, Lux will try to detect the current shell.
            Possible values: "bash", "elvish", "fish", "powershell", "zsh"
            [possible values: bash, elvish, fish, powershell, zsh]

```

#### Options

- `-h, --help` — Print help

### `lx debug`

Internal commands for debugging Lux itself

**Usage:** `lx debug <COMMAND>`

#### Subcommands

- `unpack` — Unpack the contents of a rock
- `fetch-remote` — Fetch a remote rock from its RockSpec source
- `unpack-remote` — Download a .src.rock from luarocks.org and unpack it
- `project` — View information about the current project
- `toolchains` — Check for available toolchains
- `help` — Print this message or the help of the given subcommand(s)

#### Options

- `-h, --help` — Print help

### `lx dist`

Distribute a Lux project

**Usage:** `lx dist <COMMAND>`

#### Subcommands

- `flat-archive` — Distribute an archive of a flat install tree which includes all dependencies. The resulting archive does not include the `etc` directory or build dependencies. Unlike a Lux tree, dependency conflicts are not supported/handled
- `bin` — Compile a Lux project, including its dependencies, into a single static binary, which runs on systems that do not have Lua installed. As with flat-archive, dependency conflicts are not supported/handled. The entrypoint is specified via the lux.toml's [run] field, e.g.:  ```toml [run] args = ["src/main.lua"] ```
- `help` — Print this message or the help of the given subcommand(s)

#### Options

- `-h, --help` — Print help

### `lx doc`

Show documentation for an installed rock

**Usage:** `lx doc [OPTIONS] <PACKAGE>`

#### Arguments

```
  <PACKAGE>  

```

#### Options

- `--online` — Ignore local docs and open the package's homepage in a browser
- `-h, --help` — Print help

### `lx download`

Download a specific rock file from a luarocks server

**Usage:** `lx download <PACKAGE_REQ>`

#### Arguments

```
  <PACKAGE_REQ>  

```

#### Options

- `-h, --help` — Print help

### `lx fmt`

Formats the codebase with stylua

**Usage:** `lx fmt [OPTIONS] [PATH]`

#### Arguments

```
  [PATH]
          Path to a workspace, directory, or Lua file to format. Defaults to the current workspace

```

#### Options

- `--backend <BACKEND>` — Possible values: - stylua:            Mainly follows the [Roblox Lua style guide](https://roblox.github.io/lua-style-guide/) - luafmt:            The default formatter used by [emmylua-analyzer-rust](https://github.com/EmmyLuaLs/emmylua-analyzer-rust). If invoked with `lx --lua-version=&lt;version&gt; fmt`, Lux will configure the luafmt syntax level to match the specified Lua version - emmylua-codestyle: The default formatter used by [lua-language-server](https://luals.github.io/) [default: `stylua`]
- `-p, --package <PACKAGE>` — Package to format [aliases: -p]
- `-h, --help` — Print help (see a summary with '-h')

### `lx generate-rockspec`

Generate a rockspec file from a project

**Usage:** `lx generate-rockspec [OPTIONS]`

#### Options

- `-p, --package <PACKAGE>` — Package to generate the rockspec for [aliases: -p]
- `--porcelain` — Output a JSON list of paths to the generated rockspecs
- `-h, --help` — Print help

### `lx info`

Show metadata for any rock

**Usage:** `lx info <PACKAGE>`

#### Arguments

```
  <PACKAGE>  

```

#### Options

- `-h, --help` — Print help

### `lx install`

Install a rock for use on the system

**Usage:** `lx install [OPTIONS] [PACKAGE_REQ]...`

#### Arguments

```
  [PACKAGE_REQ]...  Package or list of packages to install

```

#### Options

- `--pin` — Pin the packages so that they don't get updated
- `--force` — Reinstall without prompt if a package is already installed
- `-h, --help` — Print help

### `lx install-rockspec`

Install a local rockspec for use on the system

**Usage:** `lx install-rockspec [OPTIONS] <ROCKSPEC_PATH>`

#### Arguments

```
  <ROCKSPEC_PATH>  The path to the RockSpec file to install

```

#### Options

- `--pin` — Whether to pin the installed package and dependencies
- `-h, --help` — Print help

### `lx install-lua`

Manually install and manage Lua headers for various Lua versions

**Usage:** `lx install-lua`

#### Options

- `-h, --help` — Print help

### `lx lint`

Lint the current project using `luacheck`

**Usage:** `lx lint [OPTIONS] [PATH] [ARGS]...`

#### Arguments

```
  [PATH]     Path to a workspace, directory, or Lua file to lint. Defaults to the current workspace
  [ARGS]...  Arguments to pass to the luacheck command.
              If you pass arguments to luacheck, Lux will not pass any default arguments

```

#### Options

- `--no-ignore` — By default, Lux will add top-level ignored files and directories (like those in .gitignore) to luacheck's exclude files. This flag disables that behaviour.
- `-h, --help` — Print help

### `lx list`

List currently installed rocks

**Usage:** `lx list [OPTIONS]`

#### Options

- `--porcelain`
- `-h, --help` — Print help

### `lx lua`

**Usage:** `lx lua -- [LUA_OPTIONS] [SCRIPT [ARGS]]...`

#### Arguments

```
  [LUA_OPTIONS]...
  Available options are:
    -e stat  execute string 'stat'
    -i       enter interactive mode after executing 'script'
    -l name  require library 'name'
    -v       show version information
    -E       ignore environment variables
    --       stop handling options
    -        stop handling options and execute stdin

```

#### Options

- `--lua` — Path to the Lua interpreter to use
- `-h, --help` — Print help
- `--test` — Prepend test dependencies to the LUA_PATH and LUA_CPATH
- `--build` — Prepend build dependencies to the LUA_PATH and LUA_CPATH
- `--no-lock` — Ignore the project's lockfile and don't create one
- `--only-deps Build only the dependencies`

### `lx new`

Create a new Lua project

**Usage:** `lx new [OPTIONS] <TARGET>`

#### Arguments

```
  <TARGET>  The directory of the project

```

#### Options

- `--name <NAME>` — The project's name
- `--description <DESCRIPTION>` — The description of the project
- `--license <LICENSE>` — The license of the project. Generic license names will be inferred
- `--maintainer <MAINTAINER>` — The maintainer of this project. Does not have to be the code author
- `--labels <LABELS>` — A comma-separated list of labels to apply to this project
- `--lua-versions <LUA_VERSIONS>` — A version constraint on the required Lua version for this project. Examples: "&gt;=5.1", "5.1"
- `--main <MAIN>` — [possible values: `src, lua`]
- `-h, --help` — Print help

### `lx outdated`

List outdated rocks

**Usage:** `lx outdated [OPTIONS]`

#### Options

- `--porcelain`
- `-h, --help` — Print help

### `lx pack`

Create a packed rock for distribution, packing sources or binaries

**Usage:** `lx pack [PACKAGE_OR_ROCKSPEC]`

#### Arguments

```
  [PACKAGE_OR_ROCKSPEC]  Path to a RockSpec or a package query for a package to pack.
                          Prioritises local projects if in a workspace, then installed rocks.
                          If there is no matching workspace member or installed rock,
                          a rock will be downloaded and installed to a temporary directory.
                          In case of multiple matches, the latest version will be packed.
                          
                          Examples:
                          - "pkg"
                          - "pkg@1.0.0"
                          - "pkg>=1.0.0"
                          - "/path/to/foo-1.0.0-1.rockspec"
                          
                          If not set, lux will attempt to pack either all workspace members
                          or the current project.
                          To pack a project, lux must be able to generate a release or dev RockSpec.

```

#### Options

- `-h, --help` — Print help

### `lx path`

Return the currently configured package path

**Usage:** `lx path [OPTIONS] [COMMAND]`

#### Subcommands

- `full` — Generate an export statement for all paths (formatted as a shell command). [Default]
- `lua` — Generate a `LUA_PATH` expression for `lua` libraries in the lux tree. (not formatted as a shell command)
- `c` — Generate a `LUA_CPATH` expression for native `lib` libraries in the lux tree. (not formatted as a shell command)
- `bin` — Generate a `PATH` expression for `bin` executables in the lux tree. (not formatted as a shell command)
- `init` — Generate a `LUA_INIT` expression for the lux loader. (not formatted as a shell command)
- `help` — Print this message or the help of the given subcommand(s)

#### Options

- `--prepend` — Prepend the rocks tree paths to the system paths
- `-h, --help` — Print help

### `lx pin`

Pin an existing rock, preventing any updates to the package

**Usage:** `lx pin [OPTIONS] [PACKAGE_REQ]...`

#### Arguments

```
  [PACKAGE_REQ]...  Installed package or dependency to pin. If pinning a dependency in a project,
                    this should be the package name

```

#### Options

- `-b, --build <BUILD>` — Pin a development dependency. Also called `dev` [aliases: -d, -b]
- `-t, --test <TEST>` — Pin a test dependency
- `-p, --package <PACKAGE>` — Project to modify [aliases: -p]
- `-h, --help` — Print help

### `lx purge`

Remove all installed rocks from a tree

**Usage:** `lx purge`

#### Options

- `-h, --help` — Print help

### `lx remove`

Remove a rock from the current project's lux.toml dependencies

**Usage:** `lx remove [OPTIONS] [DEPENCENCIES]...`

#### Arguments

```
  [DEPENCENCIES]...  Package or list of packages to remove from the dependencies

```

#### Options

- `-b, --build <BUILD>` — Remove a development dependency. Also called `dev` [aliases: -d, -b]
- `-t, --test <TEST>` — Remove a test dependency
- `-p, --package <PACKAGE>` — Package to remove from [aliases: -p]
- `-h, --help` — Print help

### `lx run`

Run the current project with the provided arguments

**Usage:** `lx run [OPTIONS] [ARGS]...`

#### Arguments

```
  [ARGS]...  

```

#### Options

- `--no-loader` — Do not add `require('lux').loader()` to `LUA_INIT`. If a rock has conflicting transitive dependencies, disabling the Lux loader may result in the wrong modules being loaded
- `--dir <DIR>` — Path in which to run the command. Defaults to the project root
- `--no-lock` — Ignore the project's lockfile and don't create one
- `--only-deps` — Build only the dependencies
- `-p, --package <PACKAGE>` — Package to build [aliases: -p]
- `-h, --help` — Print help

### `lx exec`

Execute a command that has been installed with lux. If the command is not found, a package named
after the command will be installed

**Usage:** `lx exec [OPTIONS] <COMMAND> [ARGS]...`

#### Arguments

```
  <COMMAND>  The command to run
  [ARGS]...  Arguments to pass to the program

```

#### Options

- `--no-loader` — Do not add `require('lux').loader()` to `LUA_INIT`. If a rock has conflicting transitive dependencies, disabling the Lux loader may result in the wrong modules being loaded
- `-h, --help` — Print help

### `lx search`

Query the luarocks servers

**Usage:** `lx search [OPTIONS] <LUA_PACKAGE_REQ>`

#### Arguments

```
  <LUA_PACKAGE_REQ>  

```

#### Options

- `--porcelain` — Return a machine readable format
- `-h, --help` — Print help

### `lx test`

Run the test suite in the current project directory.
 Lux supports the following test backends, specified by the `[test]` table in the lux.toml:
 
 - busted:
 
 https://lunarmodules.github.io/busted/
 
 Example:
 
 ```toml
 [test]
 type = "busted"
 flags = [ ] # Optional CLI flags to pass to busted
 ```
 
 `lx test` will default to using `busted` if no test backend is specified and:
 * there is a `.busted` file in the project root
 * or `busted` is one of the `test_dependencies`).
 
 - busted-nlua:
: 
 [currently broken on Windows]
 A build backend for running busted tests with Neovim as the Lua interpreter. Used for testing
 Neovim plugins. 
 Example:
 
 ```toml
 [test]
 type = "busted-nlua"
 flags = [ ] # Optional CLI flags to pass to busted
 ```
 
 `lx test` will default to using `busted-nlua` if no test backend is specified and:
 * there is a `.busted` file in the project root
 * or `busted` and `nlua` are `test_dependencies`.
 
 - command:
 
 Name/file name of a shell command that will run the test suite.
 Example:
 
 ```toml
 [test]
 type = "command"
 command = "make"
 flags = [ "test" ]
 ```
 
 - script:
 
 Relative path to a Lua script that will run the test suite.
 Example:
 
 ```toml
 [test]
 type = "script"
 script = "tests.lua" # Expects a tests.lua file in the project root
 flags = [ ] # Optional arguments passed to the test script
 ```

**Usage:** `lx test [OPTIONS] [TEST_ARGS]...`

#### Arguments

```
  [TEST_ARGS]...  Extra arguments to pass to the test runner or test script

```

#### Options

- `--impure` — Don't isolate the user environment (keep `HOME` and `XDG` environment variables)
- `--no-lock` — Ignore the project's lockfile and don't create one
- `-p, --package <PACKAGE>` — Package to run tests for [aliases: -p]
- `-h, --help` — Print help

### `lx uninstall`

Uninstall a rock from the system

**Usage:** `lx uninstall [PACKAGES]...`

#### Arguments

```
  [PACKAGES]...  The package or packages to uninstall from the system

```

#### Options

- `-h, --help` — Print help

### `lx unpin`

Unpins an existing rock, allowing updates to alter the package

**Usage:** `lx unpin [OPTIONS] [PACKAGE_REQ]...`

#### Arguments

```
  [PACKAGE_REQ]...  Installed package or dependency to pin. If pinning a dependency in a project,
                    this should be the package name

```

#### Options

- `-b, --build <BUILD>` — Pin a development dependency. Also called `dev` [aliases: -d, -b]
- `-t, --test <TEST>` — Pin a test dependency
- `-p, --package <PACKAGE>` — Project to modify [aliases: -p]
- `-h, --help` — Print help

### `lx update`

Updates all rocks in a project

**Usage:** `lx update [OPTIONS] [PACKAGES]...`

#### Arguments

```
  [PACKAGES]...  Packages to update. When used with the --toml flag in a project, these must be
                 package names

```

#### Options

- `--no-integrity-check` — Skip the integrity checks for installed rocks when syncing the project lockfile
- `--toml` — Upgrade packages in the project's lux.toml (if operating on a project)
- `-b, --build <BUILD>` — Build dependencies to update. Also called `dev`. When used with the --toml flag in a project, these must be package names [aliases: -d, -b]
- `-t, --test <TEST>` — Build dependencies to update. When used with the --toml flag in a project, these must be package names
- `-p, --package <PACKAGE>` — Project to modify [aliases: -p]
- `-h, --help` — Print help

### `lx upload`

Generate a Lua rockspec for a Lux project and upload it to the public luarocks repository.
 You can specify a source template for release and dev packages in the lux.toml.
 
 Example:
 
 ```toml
 [source]
 url = "https://host.com/owner/$(PACKAGE)/refs/tags/$(REF).zip"
 dev = "git+https://host.com/owner/$(PACKAGE).git"
 ```
 
 You can use the following variables in the source template:
 
 - $(PACKAGE): The package name.
 - $(VERSION): The package version.
 - $(REF): The git tag or revision (if in a git repository).
 - You may also specify environment variables with `$(&lt;VAR_NAME&gt;)`.
 
 If the `version` is not set in the lux.toml, lux will search the current commit for SemVer tags and
 if found, will use it to generate the package version

**Usage:** `lx upload [OPTIONS]`

#### Options

- `--sign-protocol <SIGN_PROTOCOL>` — The protocol to use when signing upload artefacts [default: `default`] [possible values: `none, assuan, cms, default, g13, gpgconf, openpgp, spawn, uiserver`]
- `-p, --package <PACKAGE>` — Package to upload [aliases: -p]
- `-t, --tfa-code <TFA_CODE>` — Code to use for two-factor authentication (2FA). It is recommended to enable 2FA for luarocks uploads (see https://luarocks.org/settings/two-factor-auth). Lux can also generate a TOTP code if you expose your luarocks.org 2FA secret via the 'LUAROCKS_2FA_SECRET' environment variable. [aliases: -c]
- `-h, --help` — Print help

### `lx vendor`

Vendor the dependencies of a project or RockSpec locally. When building or installing a package with
the `--vendor-dir` option
 or the `[vendor_dir]` config option, Lux will fetch sources from the &lt;vendor-dir&gt;
 instead of from a remote server

**Usage:** `lx vendor [OPTIONS] [VENDOR_DIR]`

#### Arguments

```
  [VENDOR_DIR]  The directory in which to vendor the dependencies. Must be set if `--vendor-dir` is
                not set

```

#### Options

- `--rockspec <ROCKSPEC>` — RockSpec to vendor the packages for. If not set, Lux will vendor dependencies of the current project
- `--no-lock` — Ignore the project's lockfile, if present
- `--no-delete` — Don't delete the &lt;vendor-dir&gt; when vendoring, but rather keep all existing contents of the vendor directory
- `-h, --help` — Print help

### `lx which`

Tell which file corresponds to a given module name

**Usage:** `lx which <MODULE> [PACKAGES]...`

#### Arguments

```
  <MODULE>       The module to search for
  [PACKAGES]...  Only search in these packages

```

#### Options

- `-h, --help` — Print help

### `lx shell`

Spawns an interactive shell with PATH, LUA_PATH, LUA_CPATH and LUA_INIT set

**Usage:** `lx shell [OPTIONS]`

#### Options

- `--test` — Add test dependencies to the shell's paths, in addition to the regular dependencies
- `--build` — Add *only* build dependencies to the shell's paths
- `--no-loader` — Disable the Lux loader. If a rock has conflicting transitive dependencies, disabling the Lux loader may result in the wrong modules being loaded.
- `-h, --help` — Print help

### `lx sync`

Synchronize the project tree with the current lux.toml,
 ensuring all packages are installed correctly

**Usage:** `lx sync [OPTIONS]`

#### Options

- `--no-integrity-check` — Skip the integrity checks for installed rocks when syncing the project lockfile
- `-h, --help` — Print help

### `lx help`

Print this message or the help of the given subcommand(s)

**Usage:** `lx help [COMMAND]...`

#### Arguments

```
  [COMMAND]...  Print help for the subcommand(s)
```

