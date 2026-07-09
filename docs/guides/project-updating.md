---
id: project-updating
title: How to publish a new release of your project
---

This guide shows you how to publish a new version of your project to LuaRocks.

## Prerequisites

You need to have published a version before.
If not, see the [publishing guide](/guides/publishing).

## Manual version bump

Update the `version` field in your `lux.toml` following [Semantic Versioning](https://semver.org).
If you're not using a VCS, set the source archive manually. See the [lux.toml reference](/reference/lux-toml) for details.

## Automatic version detection (VCS)

If your project uses a Git-compatible VCS, create a tag matching your release version:

```sh
git tag 2.0.0
git push origin 2.0.0
```

Lux will detect the version from the tag.

### release-please

If you use `release-please`, merge its automatically generated PR (requires [Conventional Commits](https://conventionalcommits.org)).
A tag will be created on merge.

## Publishing

```sh
lx upload
```

To pass the API key inline:

```sh
LUX_API_KEY=your-key lx upload
```

See `lx upload --help` for all options.
