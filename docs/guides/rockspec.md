---
id: rockspec
title: How to use Lux with a rockspec file
---

In this guide, we'll learn how to use Lua rockspec files with Lux.

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
of your rockspec there. In our case, this will be a simplified version of `say`'s rockspec:

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

That's it! Lux will now treat the rockspec file as a first-class citizen.

:::info
See also: [The luarocks documentation on the rockspec format](https://github.com/luarocks/luarocks/blob/main/docs/rockspec_format.md)
:::

## Important Behaviour

Lux will **always prioritize the rockspec's data** over the TOML. Lux does not deeply merge content from both
files, but simply prioritizes data found in the rockspec.

For example, if you specify a project version in the TOML and a project version in the rockspec, Lux will
use the version defined in the rockspec. If you specify a `source` table in the TOML and a `source` table in the rockspec,
Lux will completely ignore all content in the TOML and use only the `source` table from the rockspec.

## Cleaning up the Rockspec

For the reasons above, you'll want to clean up the rockspec and only keep the data you really need (the more
data coming from the TOML the better). In the `extra.rockspec`, you can omit as many fields as you like, including ones
that would generally be considered required.

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
