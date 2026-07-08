---
id: multi-project-workspaces
title: How to declare a workspace with multiple projects
---

To set up a monorepo with multiple projects, declare a workspace `lux.toml` at the root
and a project `lux.toml` for each project.

## The root `lux.toml`

In your workspace root, add a `lux.toml` with the relative paths to your projects in the
`workspace.members` field:

```toml title="lux.toml at workspace root"
[worskpace]
members = [
    "projects/foo",
    "projects/bar",
]
```

Or:

```toml title="lux.toml at workspace root"
[worskpace]
members = ["glob:projects/*"]
```

Then add a `lux.toml` to each directory:

- `projects/foo/lux.toml`
- `projects/bar/lux.toml`

## Declaring local dependencies

To declare a dependency on another project in the workspace, use a local dependency:

```toml title="projects/foo/lux.toml"
# ...

[dependencies.foo]
path = "../foo"
version = "1.0.0"
```

:::important
- Declare a version so the package can be published.
- If your project lives in a subdirectory, you should also set `source.dir`.
  Make sure it points to the correct directory in any archives specified by `source.url`.
  For example, if the archive extracts to a folder named `my_project`,
  and the project is located within the subdirectory `foo/bar`, 
  set `source.dir = my_project/foo/bar`.
:::
