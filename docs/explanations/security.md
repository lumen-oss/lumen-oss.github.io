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
  Lux hashes sources and rockspecs in the lockfile.
  Mismatches are hard errors.
  Investigate integrity mismatches before using `lx --no-lock`.
- **Sandboxed rockspec parsing.**
  Rockspecs are untrusted Lua, parsed in an embedded sandbox.
- **Signature verification (opt-in).**
  Lux can check detached OpenPGP signatures on rockspecs and source rocks
  against your GPG keyring.
  Choose a policy with `--verify-policy` or the `verify` setting.
  See the [verifying packages](/guides/verifying-packages) guide.
- **Sandboxing build execution (opt-in).**
  Builds run `make`, `cmake`, `cargo`,
  and arbitrary rockspec-declared commands under your privileges.
  A *runner* hook `[build.runner]` can wrap every build command
  in a sandbox. See the [sandboxing builds](/guides/sandboxing-builds) guide.
  It covers all spawned subprocess backends.
