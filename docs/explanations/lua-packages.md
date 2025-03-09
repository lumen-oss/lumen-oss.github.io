---
id: lua-packages
title: What is a Lua package?
---

Have you ever wondered how Lua code is shipped and reused? A Lua package is referred to as a *rock*.
Rock files use the `.src.rock` file format, which is internally really just a zip file, and can be unzipped
using all traditional unzip tools.

Inside the rock, you'll usually find two main parts:
- The *rockspec*, i.e. instructions on how to build the rock.
- (optional) The *source code* of the rock (packaged in a zip file).

The most important part of any package is the rockspec, which is a single Lua file that describes
how to build a Lua package from start to finish. Below is an example of a rockspec for `say`, a Lua library
for string hashing, with added comments:

```lua title="say-1.4.1-3.rockspec"
-- (required) The name of the package
package = "say"

-- Basic variables that can be easily reused
local rock_version = "1.4.1"
local rock_release = "3"
local namespace = "lunarmodules"
local repository = package

-- (required) The version of the package
version = ("%s-%s"):format(rock_version, rock_release)

-- (required) The source of the package.
source = {
  url = ("git+https://github.com/%s/%s.git"):format(namespace, repository),
  branch = rock_version == "scm" and "master" or nil,
  tag = rock_version ~= "scm" and "v"..rock_version or nil,
}

-- (optional) Metadata about the package.
description = {
  summary = "Lua string hashing/indexing library",
  detailed = [[
    Useful for internationalization.
  ]],
  license = "MIT",
  homepage = ("https://%s.github.io/%s"):format(namespace, repository),
  maintainer = "Caleb Maclennan <caleb@alerque.com>",
}

-- (optional) Dependencies for the package.
-- Here we assert that lua must be at least version 5.1
dependencies = {
  "lua >= 5.1",
}

-- (required) Instructions to build the rock. Depending on the `type`,
-- different custom parameters can be provided to alter the behaviour of the
-- build script.
-- "builtin" is the most basic build type.
build = {
  type = "builtin",
  modules = {
    say = "src/say/init.lua"
  }
}
```

## Building a Rock

In order to build the rock, one must first:
1. Acquire the rockspec
2. Read the `dependencies` table and download all dependencies of the rock
3. Read the rockspec's `source` table and download the rock's source code
4. Read the `build` table and install the package into a [tree](/explanations/lux-trees)

:::note Reproducibility
Notice that the branch and tag are explicitly specified in the `source` field
for the git repository. This ensures that the same version of the rock is installed
every time, ensuring reproducibility.
:::

## Sharing Rocks

A rockspec is all that's necessary to wholly describe how to build a package. In that case,
where can one share and acquire these rockspecs? That's what https://luarocks.org is for.
Luarocks is a centralized hub for publishing your own packages, and its the registry that Lux
uses to find and download rocks.

When publishing to [luarocks.org](https://luarocks.org), you can choose to upload only the rockspec
or the rockspec with a copy of your source code as a zip file, in case you don't
want to host your files on something like Github.
