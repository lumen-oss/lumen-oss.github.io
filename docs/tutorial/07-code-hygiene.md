---
id: code-hygiene
title: Code Hygiene
---

Code hygiene is the practice of writing code that is readable and maintainable.
In this chapter, we'll let tools automatically clean up our code for us.

## Type checks with LuaCATS annotations

Lua is incredibly responsive when used for configuration or scripting, giving immediate feedback.
But in the context of a project that needs to be maintained long-term, its dynamic typing casts
shadows of unpredictability, making Lua projects susceptible to unexpected bugs at the wrong time.

To help mitigate this, Lux provides a `lx check` command, which uses [emmylua_check](https://github.com/EmmyLuaLs/emmylua-analyzer-rust)
to statically type-check your codebase based on [LuaCATS annotations](https://github.com/EmmyLuaLs/emmylua-analyzer-rust).

The command will:

1. Build your project and its dependencies if not done already.
2. Generate workspace library entries for a [`.luarc.json` file](https://github.com/LuaLS/lua-language-server/wiki/Configuration-File).
3. Run the static checker.

<!--TODO: show output of lx check and fix the errors that exist there-->

## Linting with `lx lint`

Linting is the process of analyzing code for potential errors and stylistic issues (lines too long, unused variables, etc.).
To lint the entire project, we can run:

```sh
lx lint
```

<!--TODO: show output of lx lint and fix the errors that exist there-->

## Formatting with `lx fmt`

Lux comes with a Lua code formatter that can automatically format your Lua code to a consistent style.
To make our code style consistent accross the codebase, we can run:

```sh
lx fmt
```

Feel free to take a look at the changes `lx fmt` made to our code!

Now that our code is nice and shiny, we're ready to move onto the final step:
publishing our code to [luarocks.org](https://luarocks.org)!
