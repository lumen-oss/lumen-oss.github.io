---
id: publishing
title: Publishing Our CLI Application
---

In this chapter, we'll learn how to publish our CLI application to [luarocks.org](https://luarocks.org)
so it can be used by others.

## API Key

To publish a rock, you need an API key. You can find your API key by logging into your account on
[luarocks.org](https://luarocks.org) and navigating to the [API Key settings](https://luarocks.org/settings/api-keys).

From here, you can create a new API key or use an existing one.
Here's an example of what the API key should look like:

```
wXnNFASnbacLCkgSzKb6t9cLSmNcO3ZV9mIaxrPK
```

:::warning Security
Keep your API key safe and secure. It's like a password and should not be shared with anyone.
The key we showed above is an example and not a real key.
:::

## Two-Factor Authentication (2FA)

Over the past years there have been a plethora of attacks on popular package registries, especially npm.
These attacks hijack API tokens to impersonate authors of popular packages and inject packages used by millions of people with malware.
For this reason, we strongly encourage absolutely everyone to set up 2FA for their luarocks account.
Head over to [the luarocks.org 2FA settings](https://luarocks.org/settings/two-factor-auth)
and scan the QR code with your favourite authenticator app.

If you plan on using a CI/CD engine that utilizes Lux for uploads, copy the secret key shown under the QR code.
To add the secret to GitHub Actions, refer to [this guide](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets).

:::warning Security
- Do not sore your 2FA secret in the same place as your API key or login credentials.
- Make sure your CI environment has a way to expose the secret to Lux via
  the `LUAROCKS_2FA_SECRET` environment variable without leaking it.
  If the secret ever gets leaked, an attacker can impersonate and freely generate 2FA keys on your behalf.
:::

![Enabling two-factor authentication](/img/luarocks-2fa.png)

After enabling 2FA, make sure to require it for uploads:

- Check the "Require 2FA for API uploads" checkbox.
- Enter your password and the verification code from your authenticator app.
- Click "Update settings".

![Enabling two-factor authentication](/img/luarocks-upload-2fa.png)

## Creating a Repository

As we mentioned in the previous chapters, a rockspec is a set of instructions
on how to build and install a rock. One of the fields in our `lux.toml`, which
isn't provided by default, is the URL source field, which points to the location
of the rock's source code.

When publishing a rock, we need to ensure that the `source.url` field points to
such a location, this is usually a GitHub repository.
If you haven't already made one, this is a good time to create a repository for your project.

Apart from creating the repository, you must also create a release for the code you published, along with a version number.
Navigate to your Github repository and press "Create new release" on the right sidebar. Afterwards, create a release named `v0.1.0`.

![Creating a release on GitHub](/img/creating-release.png)

Then press "Publish release". On your Github repository page, you should now see a release tagged `v0.1.0`!

## Adding a Source URL

Here's our updated `lux.toml` with the `source.url` field added:

```toml title="lux.toml"
package = "my-lua-project"
version = "0.1.0"
lua = ">=5.1"

[description]
summary = "A sample project."
maintainer = "vhyrro"
license = "MIT"
labels = [ "learning" ]

# highlight-start
[source]
url = "https://github.com/my-username/my-lua-project"
tag = "v0.1.0"
# highlight-end

[dependencies]
argparse = "=0.7"

[build]
type = "builtin"
```

## Publishing

With the API key in hand, we can now publish our rock.
Open your authenticator app and grab the code.
Run the following command in your project directory:

```sh
LUX_API_KEY=<your-api-key> lx upload --tfa-code "384562"
```

Lux will now package your project and upload it to luarocks!
Feel free to check out the [luarocks.org](https://luarocks.org) website to see your project listed in the "Recent Modules" section.

:::note
We also provide [a GitHub action](https://github.com/marketplace/actions/luxaction)
which you can use to automate this.
:::

## Congratulations! :tada:

You have just successfully published your first Lua package! Well done.
If you'd like to learn more about Lux, feel free to take a look at our [guides](/guides).

## Distributing an archive or a binary

Sometimes you may want to distribute your application to users who don't use Lux,
or bundle it for use in a CI/CD pipeline where installing dependencies at runtime
is impractical.

Lux provides two distribution strategies:

- **Flat archive** -- a `.zip` file containing your project and all its runtime
  dependencies, ready to be extracted and used with any Lua installation.
- **Single binary** -- a standalone executable with Lua and all dependencies
  compiled in, so users don't need Lua installed at all.

### Flat archive

From your project directory, create an archive with:

```sh
lx dist flat-archive
```

This produces a file named `<package>-<version>.zip` in your current directory.
The archive contains a flat install tree with your application and all its Lua
dependencies (except build dependencies).

:::note
Unlike a regular Lux installation,
it does not include the `lux.loader`, so conflicting dependencies between packages
are not supported.
:::

#### Specifying a destination

Use the `--destination` (or `-d`) flag to control where the archive is written:

```sh
lx dist flat-archive --destination ./dist/my-app.zip
```

If the destination is a directory, the file will be placed inside it with the
default name.

#### Choosing a compression method

By default the archive uses the `stored` method (no compression), which is fastest.
You can choose a different compression method with `--compression-method` (or `-c`):

```sh
lx dist flat-archive --compression-method deflated
```

Run `lx dist flat-archive --help` to see the available compression methods.

### Single static binary

Lux can compile your project into a single static binary that runs on systems
without Lua installed. The `[run]` section we set up earlier tells Lux where
the entrypoint is. It uses this to know what to compile into the binary.
Simply run:

```sh
lx dist bin
```

This produces an executable named after your package (e.g. `my-lua-project`)
in the current directory.

#### Output path

Use the `--output` (or `-o`) flag to choose where the binary is written:

```sh
lx dist bin --output ./dist/my-app
```

:::note
Compiling native Lua modules into a static binary is currently supported on Linux only.
On other platforms, projects with C dependencies will produce a build error.
:::
