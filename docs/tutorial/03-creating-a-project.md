---
id: creating-a-project
title: Creating a Project
---

In the next chapters we will learn how to create, manage and publish a small Lua CLI
that checks whether a sentence provided to the program contains the string "hello".
We will cover dependencies, the `lux.toml` format and more all the way up to API keys!

To start writing Lua, we must initialize a project where we will store our code.
We'll do this in a `my-lua-project/` directory.
To create a project, we can run:

```bash
lx new my-lua-project
```

We'll now be asked to provide information about our project so Lux can generate
the appropriate skeleton code. Below is the output of the application, as well as
the values we will provide. For the "Maintainer" field, feel free to provide your
own name or username!

```
✔ Fetched remote repository metadata.
> Package name: my-lua-project
> Description: A sample project.
> License: MIT
> Labels: learning
> Maintainer: vhyrro
> What is the lowest Lua version you support? 5.1
Done!
```

:::info could not fetch repo metadata
Depending on the speed of your computer you may have noticed that we got a
warning saying "could not fetch remote repo metadata" for a brief moment before
disappearing and showing the prompts. This is not an issue, has no impact and
can be safely ignored.
<!--see [the explanation](todo-path-to-explanation) if you're interested.-->
:::

## Exploring Our Project

You'll see that our `my-lua-project/` directory was created. Let's enter the directory
and get to work!

Inside of our project, you should see that a basic project skeleton was created:

```bash title="tree $(pwd)"
/home/your-username/my-lua-project
├── lux.toml
└── src
    └── main.lua
```

The `lux.toml` file describes instructions on how to build and ship your Lua code.
Let's enter the file. You should see contents similar to the following:

```toml title="lux.toml"
package = "my-lua-project"
version = "0.1.0"
lua = ">=5.1"

[description]
summary = "A sample project."
maintainer = "vhyrro"
labels = [ "learning" ]
license = "MIT"

[dependencies]
# Add your dependencies here
# `busted = ">=2.0"`

[run]
args = [ "src/main.lua" ]

[build]
type = "builtin"
```

## Checking our Progress

To check whether our project was made successfully, first make sure you're in
the `my-lua-project/` directory; afterwards, you can run a secret command:

```bash
lx debug project
```

This will show information about the project only if it was properly created.
You should see the following output:

```
Project name: my-lua-project
Project version: 0.1.0-1
Project location: /home/your-username/my-lua-project
```

Congratulations! We're now ready to start adding some dependencies in the next chapter.
