---
id: multi-project-workspaces
title: How to declare a workspace with multiple projects
---

Lux supports monorepos with multiple projects. You need to declare a workspace TOML
at the root directory, and a project TOML for each project.

## The root `lux.toml`

In your workspace root, add a `lux.toml` with the relative paths to your projects in the
`workspace.members` field:

```toml title="lux.toml at workspace root"
[worskpace]
members = [
    "projects/foo"
    "projects/bar"
]
```

Then add a `lux.toml` to each directory:

- `projects/foo/lux.toml`
- `projects/bar/lux.toml`

## Declaring local dependencies

If one of your projects depends on the other, you can make sure Lux builds the
local package by declaring local dependencies:

```toml title="projects/foo/lux.toml"
# ...

[dependencies.foo]
path = "../foo"
version = "1.0.0"
```

:::important
You should still declare a version so that the package can be published
:::
