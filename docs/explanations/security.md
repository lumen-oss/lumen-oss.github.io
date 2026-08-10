---
slug: /explanations/security
id: security
title: How does Lux keep you safe?
sidebar_label: Security
---

Installing a rock runs the package's build code with your user privileges.
Treat every install like running an unknown program.

:::important
Never run `lx` as root!
:::

## What lux protects

- **Source integrity checks.**
  Lux hashes sources and rockspecs in the lockfile;
  mismatches are hard errors.
  Investigate integrity mismatches before using `lx --no-lock`.
- **Sandboxed rockspec parsing.**
  Rockspecs are untrusted Lua, parsed in an embedded sandbox.
- **Sandboxing build execution (opt-in).**
  Builds run `make`, `cmake`, `cargo`,
  and arbitrary rockspec-declared commands under your privileges.
  A *runner* hook `[build.runner]` can wrap every build command
  in a sandbox; see the [sandboxing builds](/guides/sandboxing-builds) guide.
  It covers all spawned subprocess backends.
