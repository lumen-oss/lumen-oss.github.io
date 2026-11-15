---
id: verifying-packages
title: How to verify package signatures
sidebar_label: Verify package signatures
---

Lux can verify OpenPGP signatures on downloaded rockspecs and source rocks.
Verification is opt-in.

## Import the signer's key

Lux verifies signatures against your GPG keyring.
It does not download keys automatically.
Import the key published by the package maintainer:

```sh
gpg --import maintainer.asc
```

Or, for a key published on a keyserver:

```sh
gpg --recv-keys <fingerprint>
```

Check that the fingerprint matches the one published by the maintainer.

## Enable verification

For a single command:

```sh
lx --verify-policy require install <package>
```

`--verify-policy` accepts `off`, `warn`, and `require`.

To enable it for a project, set `verify` in the workspace config:

```toml title=".lux/config.toml"
verify = "require"
```

The same setting can be added to the global config file
at the path reported by `lx config`. The workspace setting overrides the
global setting. The default is `off`.

## What gets verified

- Downloaded rockspecs (`.rockspec`).
- Downloaded source rocks (`.src.rock`), including lockfile-pinned URLs.

Lux does not verify source archives or git checkouts. The rockspec is the
signed artifact. Binary rocks are not verified.

## Policy behavior

| Policy | Missing or invalid signature | Revoked or expired key |
|---|---|---|
| `off` | Not checked | Not checked |
| `warn` | Warn and continue | Fail |
| `require` | Fail | Fail |

When the policy is `require`, binary rocks are excluded from package selection
because they cannot be verified. If a package is only available as a binary
rock, the install fails. When the policy is `warn`, each binary artifact
produces one warning.

## Lua API

```lua
local config = lux.config.builder():verify("warn"):build()
print(config:verify()) -- "warn"
```

## Caveats

- Most rocks on luarocks.org are currently unsigned, so a `require` verify policy
  will reject them.
- Revoked and expired keys are hard failures even under `warn`.
- Lux does not pin signer keys or maintain a trust store.
  The trust decision is your GPG keyring.
