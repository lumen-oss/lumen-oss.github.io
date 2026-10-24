---
slug: /guides/access-tokens
id: access-tokens
title: How to configure access tokens
sidebar_label: Access tokens
---

Lux fetches rocks, rockspecs, and git dependencies over HTTP(S).
Access tokens authenticate you with the host, which is required for private
repositories.

Even for public repositories, configuring an access token is worthwhile:
authenticated requests are less likely to be rate limited.

## Configure tokens

You can configure access tokens either in the `[access_tokens]` section of your
config file, or via the `LUX_ACCESS_TOKENS` environment variable.

Open your config file with:

```sh
lx config edit
```

Then add a `[access_tokens]` section, mapping each host to its token:

```toml
[access_tokens]
"github.com" = "ghp_1234abcd"
"gitlab.com" = "PAT:glpat-1234abcd"
"codeberg.org" = "cb_1234abcd"
"git.sr.ht" = "s3cr3t"
```

:::note
On GitHub Actions runners, Lux will automatically pick up the [`GITHUB_TOKEN`](https://docs.github.com/en/actions/tutorials/authenticate-with-github_token)
environment variable.
:::

## Token types

Lux recognizes the following token types:

| Type | Syntax | Hosts |
|---|---|---|
| Plain token | `<token>` | GitHub, Codeberg, and other Gitea-compatible forges, and SourceHut |
| GitLab personal access token | `PAT:<token>` | GitLab |
| GitLab OAuth2 token | `OAuth2:<token>` | GitLab |

The type determines how the token is sent, e.g. a GitLab personal access token
is sent in the `PRIVATE-TOKEN` header, while a plain token is sent in the
`Authorization` header.

## Environment variable

As an alternative to the config file, set the `LUX_ACCESS_TOKENS` environment
variable to a whitespace-separated list of `host=token` pairs:

```sh
export LUX_ACCESS_TOKENS="github.com=ghp_1234abcd gitlab.com=OAuth2:glpat-1234abcd"
```

## Precedence

Lux resolves the token for a host in this order:

1. The `LUX_ACCESS_TOKENS` environment variable.
2. The `[access_tokens]` section of the config file.
3. The `GITHUB_TOKEN` environment variable, for `github.com` only.

## Git dependencies

The same tokens are used for git-over-HTTPS authentication when fetching
[git dependencies](/reference/lux-toml#dependencies).
