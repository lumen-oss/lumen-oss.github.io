---
id: creating-a-project
title: Creating a Project
---

In the next chapters we will learn how to create, manage and publish a Lua project.
We will cover dependencies, the `rocks.toml` format and more all the way up to API keys!

To start writing Lua, we must initialize a project where we will store our code.
We'll store our code in a `my-lua-project/` directory.
To do so, we can run:

```bash
rocks new my-lua-project
```

We'll now be asked to provide information about our project so `rocks` can generate
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
disappearing and showing the prompts. This is not an issue, has no impact and can be safely
ignored, see [the explanation](todo-path-to-explanation) if you're interested.
:::

### Checking out Our Project

You'll see that our `my-lua-project/` directory was created. Let's enter the directory
and start work on our project!

Inside of our project, you should see a single file was generated:

```bash title="tree $(pwd)"
/home/vhyrro/my-lua-project
└── rocks.toml
```

Let's enter the file. Here's the contents of the project file:

```lua title="rocks.toml"
package = "my-lua-project"
version = "0.1.0"

[description]
summary = "A sample project."
maintainer = "vhyrro"
license = "MIT"
labels = ["learning"]

[dependenies]
lua = ">= 5.1"

[build]
type = "builtin"
```

The `rocks.toml` file describes instructions on how to build and ship your Lua code.

### Checking our Progress

To check whether our project was made successfully, first make sure you're in the `my-lua-project` directory.
Now, you can run a secret command:

```bash
rocks debug project
```

This will show information about the project if it was properly created. If everything
went smoothly, you should see the following output:

```
Project Name: my-lua-project
Project Version: 0.1.0-1
Project location: /home/vhyrro/my-lua-project
```

We're almost ready to write some meaningful code in the next chapter!
