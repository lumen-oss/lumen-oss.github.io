---
id: code-hygiene
title: Code Hygiene
---

In this chapter, we'll run Lux's type checker, linter, and formatter on our
project to catch issues and keep the code consistent.

## Type checking

Lux can statically type-check your Lua code using
[LuaCATS annotations](https://github.com/EmmyLuaLs/emmylua-analyzer-rust).
Let's run it on our project:

```sh
lx check
```

Everything should pass with no errors.

Now let's see what happens when there's a type mismatch. Open
`src/has_hello.lua` and change the `input` parameter annotation
from `string` to `integer`:

```lua
---@param input integer
local function has_hello(input)
```

Run `lx check` again:

```sh
lx check
```

This time Lux should report that `string:lower()` can't be called on
an `integer`. Go ahead and change the annotation back to `string`.

## Linting with `lx lint`

Lux uses [luacheck](https://github.com/lunarmodules/luacheck) to detect
potential errors and style issues. Let's try it on our project:

```sh
lx lint
```

No issues should be reported.

Now let's introduce one. Open `src/has_hello.lua` and add an unused local
variable:

```lua
local unused = true
local function has_hello(input)
```

Run `lx lint` again:

```sh
lx lint
```

Lux should report that `unused` is assigned but never used. Remove the line
and re-run to confirm the warning is gone.

## Formatting with `lx fmt`

Let's format our code:

```sh
lx fmt
```

Feel free to take a look at the changes `lx fmt` made to our code!

Now that our code is nice and shiny, we're ready to move onto the final step:
publishing our code to [luarocks.org](https://luarocks.org)!
