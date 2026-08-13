---
id: environment-variables
title: Environment variables reference
---

## `LUX_API_KEY`

API key for authenticating with [LuaRocks](https://luarocks.org).

Required by `lx upload`. Obtain your key from the [API key settings](https://luarocks.org/settings/api-keys) page.

## `LUAROCKS_2FA_SECRET`

Secret key for generating TOTP codes for two-factor authentication.

Lux reads this variable to automatically generate 2FA codes during `lx upload`, eliminating the need for the `--tfa-code` flag.
Obtain the secret from the [2FA settings](https://luarocks.org/settings/two-factor-auth) page on LuaRocks.

## `LUX_ACCESS_TOKENS`

Access tokens for fetching from private repositories, as a whitespace-separated
list of `host=token` pairs.

```sh
export LUX_ACCESS_TOKENS="github.com=ghp_1234abcd gitlab.com=OAuth2:glpat-1234abcd"
```

See [How to configure access tokens](/guides/access-tokens) for supported token
types and hosts.
