---
id: rockspec
title: How to use Lux with a rockspec file
---

In this guide, we'll learn how to use rockspec files with Lux.

:::note
Using TOML is highly recommended due to ease-of-use. We recommend only following this guide
if you have an existing, complex rockspec and do not want to waste the effort porting it.
:::

## Create a Project

Various functions related to rockspecs (e.g. uploading, building and testing) require that you have made a project.

If you haven't, be sure to run:

```sh
lx new .
```

In the directory containing your code.

## `extra.rockspec`

Lux expects a rockspec to exist in an `extra.rockspec` file. Create that file in your project's root and paste the content
of your rockspec there:

```lua title="extra.rockspec"
package = "say"
version = "0.1.0-1"

source = {
  url = "git+https://github.com/my/project",
}

build = {
  type = "builtin",
  modules = {
    say = "src/my-project/init.lua"
  }
}
```

This is all that's required - Lux will now pull information from the rockspec file whenever it needs.

## Important Behaviour

Lux will **always prioritize the rockspec's data** over the TOML. Lux does not deeply merge content from both
files, but simply prioritizes data found in the rockspec.

For example, if you specify a project version in the TOML and a project version in the rockspec, Lux will
use the version defined in the rockspec. If you specify a `source` table in the TOML and a `source` table in the rockspec,
Lux will completely ignore all content in the TOML and use only the `source` table from the rockspec.

## Cleaning up the Rockspec

For the reasons above, you'll want to clean up the rockspec and only keep the data you really need (the more
data coming from the TOML the better). In the case of `extra.rockspec`, Lux allows you to omit any fields, including ones
that would generally be considered required fields.

Following the previous section, here's an example of a cleaned up rockspec:

```lua title="extra.rockspec"
build = {
  type = "builtin",
  modules = {
    say = "src/my-project/init.lua"
  }
}
```

Notice how we removed all the fields apart from the ones we are interested in overriding.
In this case, we were only interested in overriding the `build` table.

After cleanup, feel free to continue using Lux as if nothing ever happened.
