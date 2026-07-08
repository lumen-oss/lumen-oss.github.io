---
id: publishing
title: How to publish a Lua project
---

This guide shows you how to publish a Lua project to [LuaRocks](https://luarocks.org).

## Host your code

Push your code to a public Git forge repository and note its URL.

## Choosing a version

Choose a [SemVer](https://semver.org/) version number. Set it in your `lux.toml` or create a git tag (with optional `v` prefix) — Lux will detect it automatically.

## Configuring a source URL

With the URL in hand, open your project's `lux.toml` and add the following section:

```toml title="lux.toml"
package = "my-lua-project"
version = "0.1.0"

# highlight-start
[source]
url = "https://github.com/my-username/my-project/archive/refs/tags/$(REF).zip"
dev = "git+https://github.com/my-username/my-project.git"

# highlight-end

...
```

`url` is a SemVer release URL template; Lux substitutes `$(REF)` with the tag or revision.
`dev` is a dev release URL template.

:::note
You could also specify `v$(VERSION)` to inject the version instead.
Additionally, you can inject the package name via `$(PACKAGE)`
or any environment variable via `$(VAR_NAME)`.
:::

:::important
The `dev` URL must use the `git+https://` protocol to instruct Lux to use `git`.
:::

## Acquiring an API key

You can find your API key by logging into your account on
[luarocks.org](https://luarocks.org) and navigating to the [API Key
settings](https://luarocks.org/settings/api-keys).

From here, you can create a new API key or use an existing one.
Here's an example of what an API key looks like:

```
wXnNFASnbacLCkgSzKb6t9cLSmNcO3ZV9mIaxrPK
```

:::warning Security
Keep your API key safe and secure. It's like a password and should not be shared
with anyone. The key shown above is an example and not a real key.
:::

## Two-factor authentication (2FA)

Set up 2FA on your LuaRocks account (recommended). Go to the [2FA settings](https://luarocks.org/settings/two-factor-auth)
and scan the QR code with your authenticator app.

If you plan on using Lux in CI/CD, copy the secret key shown under the QR code.
You can expose it to Lux via the `LUAROCKS_2FA_SECRET` environment variable.

:::warning Security
- Do not store your 2FA secret in the same place as your API key or login credentials.
- Make sure your CI environment exposes the secret to Lux without leaking it.
- If the secret gets leaked, an attacker can generate 2FA codes on your behalf.
:::

After enabling 2FA, make sure to require it for uploads:
- Check the "Require 2FA for API uploads" checkbox.
- Enter your password and the verification code from your authenticator app.
- Click "Update settings".

### Configuring `direnv` (optional)

Store your API key in a `.env` file and load it with [`direnv`](https://direnv.net/)
to prevent leaking through shell history.

Once you've configured `direnv`, set `LUX_API_KEY` to your key:

```plain title=".env"
LUX_API_KEY=your-key-here
```

## Publishing

If you have 2FA enabled, pass a code from your authenticator app with `--tfa-code`:

```sh
lx upload --tfa-code "384562"
```

Or, if you've configured `LUAROCKS_2FA_SECRET`, you don't need the flag —
Lux will generate a code automatically.

If you've configured `direnv`, you can omit the explicit `LUX_API_KEY`:

```sh
lx upload
```

Otherwise, provide your API key as an exported environment variable:

```sh
LUX_API_KEY=your-key lx upload
```

:::note
Lux also provides a [GitHub Action](https://github.com/marketplace/actions/luxaction)
for automating publishing in CI/CD.
:::

## Distributing artifacts

### Flat archive

From your project directory, run:

```sh
lx dist flat-archive
```

This produces `<package>-<version>.zip` containing your project and all its
runtime dependencies. The `--destination` (or `-d`) flag controls where the
archive is written:

```sh
lx dist flat-archive --destination ./dist/my-app.zip
```

Compression can be configured with `--compression-method` (or `-c`):

```sh
lx dist flat-archive --compression-method deflated
```

Run `lx dist flat-archive --help` for the full list of compression methods.

#### Distributing other packages

You can also create an archive of any package available on luarocks.org:

```sh
lx dist flat-archive argparse
lx dist flat-archive "argparse@0.7.0"
```

Or from a RockSpec path:

```sh
lx dist flat-archive /path/to/foo-1.0.0-1.rockspec
```

### Single binary

To compile your project into a static executable that does not require Lua,
add a `[run]` section to your `lux.toml` pointing to the entrypoint:

```toml title="lux.toml"
[run]
args = ["src/main.lua"]
```

Then build with:

```sh
lx dist bin
```

Use `--output` (or `-o`) to specify the destination path:

```sh
lx dist bin --output ./dist/my-app
```

:::note
Compiling native Lua modules into a static binary is currently supported on
Linux only. On other platforms, projects with C dependencies will produce
a build error.
:::

Both commands support `--porcelain` for machine-readable JSON output, useful
for scripting or CI/CD pipelines.
