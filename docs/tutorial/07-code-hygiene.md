---
id: code-hygiene
title: Code Hygiene
---

<!--TODO: extract this whole section into a set of guides-->

Code hygiene is the practice of writing code that is readable and maintainable.
In this chapter, we'll learn how Lux can help us maintain code hygiene in our
Lua projects.

## Linting with `luacheck`

Linting is the process of analyzing code for potential errors and stylistic issues (lines too long, unused variables, etc.).
Lux comes with `luacheck`, a linter for Lua code, built-in. To run `luacheck` on your project, use the following command:

```sh
lx check
```

<!--TODO: Add output of `lx check` command for our current code and see if there are any issues.-->

## Formatting with `stylua`

`stylua` is a Lua code formatter that can automatically format your Lua code to a consistent style.
Lux vendors `stylua` and provides a command to format your Lua files:

```sh
lx fmt
```

Doing so will format according to your
[`.stylua.toml`](https://github.com/JohnnyMorganz/StyLua?tab=readme-ov-file#options)
file, defined in the project root. Otherwise, it will use the default style.

## Git Hooks

We recommend setting up a Git hook to run `lx check` and `lx fmt` before
each commit to ensure that you never forget to lint and format your code.

To set up a Git hook, create a file called `.git/hooks/pre-commit` in your
project directory with the following content:

```sh
#!/bin/sh

lx check
lx fmt
```

Make sure to make the file executable:

```sh
chmod +x .git/hooks/pre-commit
```

Now, every time you commit changes to your project, `lx check` and `lx fmt` will run automatically!
