---
id: testing
title: How to test a Lua project
---

This guide shows you how to set up and run tests for a Lua project.

## Creating spec files

Specify the test backend in your `lux.toml`:

```toml title="lux.toml"
[test]
type = "busted"
```

If a `.busted` file exists in your project root, Lux will auto-detect `busted` and this configuration is optional.

Tests go in a `spec/` directory. Only files ending in `_spec.lua` are picked up.

Example:

```lua title="spec/request_parse_spec.lua"
describe("request parsing", function()
    it("should successfully parse requests into json", function()
        local req = assert(request.get("https://example.com"))
        local j = json.from(req)
        assert.is_equal(j.response == 200)
    end)
end)
```

## Running tests

```sh
lx test
```

:::note
It may take a while to install `busted` the first time.
:::

Output:

```sh title="lx test"
●●
2 successes / 0 failures / 0 errors / 0 pending : 0.001615 seconds
```

See `lx test --help` for available backends and options.

## Customizing with `.busted`

To change the test directory or Lua interpreter, create a `.busted` file in your project root:

```lua title=".busted"
return {
    _all = {
        coverage = false,
        pattern = "tests%.lua$",
        lua = "nlua",
        ROOT = { "lua/" },
    },
}
```

### Testing with Pandoc

Configure `busted` to use the `pandoc` Lua interpreter:

```lua title=".busted"
return {
    pandoc = {
        lua = "pandoc lua",
    },
}
```

Run with:

```sh
lx --lua-version 5.4 test -- --run pandoc
```

:::note
The Lua version must match the one embedded in `pandoc`.
:::

:::important
The embedded Lua interpreter must support dynamic module loading. Some `pandoc` binaries
(including the official distribution and conda-forge) are built without this support.
:::

## Alternate test backends

See the [test section in the lux.toml reference](/reference/lux-toml#test) for supported backends.
