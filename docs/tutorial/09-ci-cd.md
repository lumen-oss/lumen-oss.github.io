---
id: cicd
title: Automating tests and releases
---

Continuous integration and deployment (CI/CD) allows us to automatically run tests against external
contributions and upload our package whenever we publish a release.
In this chapter, we'll learn how to set up the [Lux GitHub Action](https://github.com/marketplace/actions/luxaction).

:::note
We plan on creating integrations for other CI/CD platforms, too.
For now, you can use [Nix](https://nixos.org/) or an [AUR helper](https://wiki.archlinux.org/title/AUR_helpers)
to install Lux on other platforms.
:::

## Running tests

So far, we've been developing and testing on our host platform.
But our users might be using other platforms. To make sure our application works for them,
we can run tests using GitHub Actions.

First, create a `.github/workflows` directory in the root of your project.
In that directory, add a `tests.yml` file with the following content:

```yaml
---
name: Lux
on:
  pull_request:
  push:
    branches: [main]

jobs:
  lux-action:
    name: ${{ matrix.job.target }} - Lua ${{ matrix.lua_version }}
    runs-on: ${{ matrix.job.os }}
    strategy:
      fail-fast: false
      matrix:
        job:
          - { os: ubuntu-24.04, target: x86_64-linux }
          - { os: ubuntu-24.04-arm, target: aarch64-linux }
          - { os: macos-14, target: aarch64-darwin }
          - { os: windows-2025, target: x86_63-windows-msvc }
        lua_version:
          - 5.1
          - 5.2
          - 5.3
          - 5.4
    steps:
      - name: Checkout repository
        uses: actions/checkout@v5

      - name: Install MSVC Compiler Toolchain
        uses: ilammy/msvc-dev-cmd@v1
        if: endsWith(matrix.job.target, '-msvc')

      - name: Install Lux
        uses: lumen-oss/gh-actions-lux@v1
        with:
          version: 0.18.8

      - name: Run tests
        run: |
          lx --lua-version ${{ matrix.lua_version }} test
```

This workflow will run

- On each pull request.
- Whenever someone pushes to the `main` branch.

It runs on Linux (x86_64 + aarch64 architecures), macOS (aarch64) and Windows (x86_64),
once for each Lua version from 5.1 to 5.4.

:::important
For reproducibility, we recommend pinning the Lux version with the `version` input.
This will prevent your workflow from breaking if we release a new version of Lux with a breaking change.
:::

## Automating releases

### Installing release-please

Because of the way we'll be setting up the workflow later on, it is recommended that you install [`release-please`](https://github.com/googleapis/release-please-action),
a tool that automates the semver process.
All you do is write commits in the [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)
style (for example `fix: annoying bug` or `feat(ui): add new buttons`) and release-please generates
a new release version in the form of a pull request to your repository.

:::note
The pull request made by the Github action gets updated on every new commit that you make - this means you control
when a new version of your package is published by **merging the pull request**.

When you do this, a new tag and release will be created on your repository, which is a critical step.
:::

In your repository root, create a file under `.github/workflows/release-please.yml`.
Paste the following contents into the file:

```yaml
---
name: Release Please

on:
  push:
    branches: [main]
  workflow_dispatch: # Enables manual triggers

permissions:
  contents: write
  pull-requests: write

jobs:
  release:
    name: release
    runs-on: ubuntu-latest
    steps:
      - uses: googleapis/release-please-action@v4
        with:
          token: ${{ secrets.PAT }}
          release-type: simple
```

Note that we pass in a `${{ secrets.PAT }}` repository secret via the `token` input,
which we'll need to generate.
This will allow the "publish" workflow (which we'll set up next) to be triggered by the
release-please workflow.
The process is quite simple, so let's get it over with.

### Generating a PAT (Personal Access Token)


1. Navigate to your Account -> Settings.

   ![settings](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/52cce7d0-b53c-467f-a3d9-a1bd6a1e1614)

2. Navigate to the "Developer Settings" tab on the very bottom of the Settings tab.

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/0452ab2a-3f2f-4162-a8f4-411ba6bd2f37)

3. Make your way over to Personal Access Tokens -> Tokens (classic). We won't need fine-grained tokens for this simple task.

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/863a5358-551c-4f44-b31b-85bb906cbc21)

4. Generate a new classic token.

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/72693b75-1a65-4bb7-8e01-bb256aa4db15)

5. Modify the highlighted sections to the values shown on screen.

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/534f49a0-d46d-422e-9c29-92d6f54dd640)

6. Press "Generate Token"!

7. **Copy your PAT to the same place where you stored your LuaRocks API key in the previous tutorial**. Make sure it's somewhere safe!

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/46c8d326-5534-447e-9268-670b872e3144)


### Publishing to LuaRocks

After your repository has a working versioning scheme we may now move on to actually publishing
our package to luarocks.

It is recommended that your repository has as much metadata as possible (a license that is detected by github on the right side of your package's page, a repo title/description, github topics etc.) in your Github repository.

Time to add our API key!

### Adding our API Key and PAT

1. Navigate to your Github repository and enter its settings.

   ![image](https://github.com/vhyrro/sample-luarocks-plugin/assets/76052559/3fab5791-189f-42cb-b8b2-824af45a114d)

2. In the settings go to `Security > Secrets and variables > Actions`.

   ![image](https://github.com/vhyrro/sample-luarocks-plugin/assets/76052559/ab8ca077-3f8a-4263-9583-2abcebdf9e6a)

3. Click `New repository secret`, almost there!

   ![image](https://github.com/vhyrro/sample-luarocks-plugin/assets/76052559/a67ddd29-5021-4d45-ae74-8a40507ccc51)
4. Name the secret `LUX_API_KEY` (make sure it's spelled exactly like this!). In the `Secret` field paste
   the API key you copied from the first step of the tutorial.

   ![image](https://github.com/vhyrro/sample-luarocks-plugin/assets/76052559/48590516-cf03-43a4-9ded-575c5a63caf5)

Click `Add secret` and there you go! This secret is only visible to you (the
repo owner) and administrators of your repository, so don't be afraid of anyone using it without your consent!

:::important
If you also set up `release-please` earlier in the tutorial, create *another* secret called `PAT` (make sure it's called
exactly like this!). In the `Secret` field paste in your **Github Personal Access Token** that you copied earlier.
:::

### Publishing to LuaRocks

Similarly to the `release-please` setup process, create a `.github/workflows/publish.yml` file from the root of your repo.

Paste the following into the file:

```yaml
---
name: Lux upload
on:
  push:
    tags: # Will upload to luarocks.org when a tag is pushed
      - "*"
  workflow_dispatch:
jobs:
  luarocks-upload:
    runs-on: ubuntu-22.04
    steps:
      - name: Checkout repository
        uses: actions/checkout@v5

      - name: Install Lux
        uses: lumen-oss/gh-actions-lux@v1
        with:
          version: 0.18.8

      - name: Upload
        run: |
          lx upload
        env:
          LUX_API_KEY: ${{ secrets.LUX_API_KEY }}
```

## Publish a Release of your package

Now that we have everything set up, all the pieces can fall into place.
Go to the Pull Requests tab in your repository where `release-please` should have created a PR for you
(assuming your were using conventional commits). Merge that pull request, and the chain reaction should begin!
First, release-please should (after a minute or so) publish a new tag with a version. Afterwards, the "publish"
workflow should trigger and your package should end up on `luarocks.org`!

## Troubleshooting

### I already merged the release-please PR earlier!

If you merged your PR beforehand, don't worry. We'll need to install the `gh` CLI tool in order to run
the workflow manually. There are many resources for that online, just search "setting up the gh cli tool" in
your favourite search engine! After you are logged in, run `gh workflow run publish.yml`.
After a minute you should see your package on luarocks :D
