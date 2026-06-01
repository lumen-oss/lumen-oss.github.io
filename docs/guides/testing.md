---
id: testing
title: How to test a Lua project
---

In this guide, we'll learn how to set up a testing suite for a Lua project.

## Creating Spec Files

By default, will try to auto-detect your test suite.
If there is a `.busted` file in your project root,
Lux will use[`busted`](https://github.com/lunarmodules/busted) as its test backend.
Otherwise, you must specify the test backend in your `lux.toml`:

```toml title="test specification"
[test]
type = "busted"
```

With busted, tests are stored in a `spec/` directory in the root of your project, and only files
ending in `_spec.lua` are considered tests.

The type of tests you will make will vary greatly depending on the type of project at hand.
Nevertheless, refrain from making trivial tests - they bring little value to a codebase.

Below is an example of a test:

```lua title="spec/request_parse_spec.lua"
local request = require("mylib.request")
local json = require("mylib.json")

describe("request parsing", function()
    it("should successfully parse requests into json", function()
        local req = assert(request.get("https://example.com"))

        local j = json.from(req)

        assert.is_equal(j.response == 200)
    end)
end)
```

Notice how it tests the interactions between many aspects of the application.

Feel free to create any amount of tests you see fit before running the test suite.

## Running Tests

Running tests is done trivially by executing the command:

```sh
lx test
```

:::note
It may take a while to install `busted` for the first time.
:::

Upon completion, you should see a summary of all tests, optionally stating anything that went wrong:

```sh title="lx test"
●●
2 successes / 0 failures / 0 errors / 0 pending : 0.001615 seconds
```

## Customizing Tests

If you'd like to change the directory that Lux uses when searching for tests, or would like to customize the Lua interpreter
to be used, create a `.busted` file in the root of your project directory.

Below is an example of such a file:

```lua title=".busted"
return {
    _all = {
        -- Don't evaluate test coverage
        coverage = false,
        -- Tests should match this pattern
        pattern = "tests%.lua$",
        -- Use a custom Lua interpreter
        lua = "nlua",
        -- Search inside of the `lua/` directory
        ROOT = { "lua/" },
    },
}
```

For full reference, see [the `busted` website](https://lunarmodules.github.io/busted).

## Alternate Test Backends

You don't have to use `busted` as a test backend.
See the test section in [How to declare a lux.toml file](/guides/lux-toml)
for alternate test backends.

## Testing with Pandoc

[`pandoc`](https://pandoc.org/) supports custom Lua filters and integrates an embedded Lua interpreter. 

`busted` can be configured to test Lua filters using the `pandoc` Lua interpreter by setting 
`lua = pandoc lua` in the `.busted` configuration file:

```lua title=".busted"
return {
    pandoc = {
        lua = "pandoc lua",
    },
}
```

Then, run the tests with `lx --lua-version 5.4 test -- --run pandoc`.

:::note
Make sure that `lx test` is invoked with the Lua version matching the one embedded in `pandoc`
:::

:::important
In order to run tests with `pandoc`, the embedded Lua interpreter must support dynamic module loading.
However, some `pandoc` binaries are built without this support, including the binary distributed 
by the pandoc project and conda-forge. See the [installation documentation](https://pandoc.org/installing.html) 
for more information.
:::
