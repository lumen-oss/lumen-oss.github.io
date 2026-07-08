---
id: cicd
title: Automating tests and releases
---

Continuous integration and deployment (CI/CD) allows us to automatically run tests against external
contributions and upload our package whenever we publish a release.
In this chapter, we'll learn how to set up the [Lux GitHub Action](https://github.com/marketplace/actions/luxaction).

:::note
We plan on creating integrations for other CI/CD platforms, too.
:::

## Running tests

So far, we've been developing and testing on our host platform.
But our users might be using other platforms. To make sure our application works for them,
we can run tests using GitHub Actions.

First, create a `.github/workflows` directory in the root of our project.
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
          - { os: macos-14, target: aarch64-darwin }
        lua_version:
          - 5.1
          - 5.4
    steps:
      - name: Checkout repository
        uses: actions/checkout@v7

      - name: Install Lux
        uses: lumen-oss/gh-actions-lux@v1
        with:
          version: 0.35.2

      - name: Run tests
        run: |
          lx --lua-version ${{ matrix.lua_version }} test
```

Let's commit and push this to our repository. Once the workflow runs, we should see
green checkmarks in the GitHub Actions tab — that means our tests passed on Linux and
macOS for both Lua 5.1 and 5.4.

:::important
For reproducibility, we recommend pinning the Lux version with the `version` input.
This prevents our workflow from breaking when a new version of Lux ships a breaking change.
:::

## Automating releases

### Installing release-please

We'll use [`release-please`](https://github.com/googleapis/release-please-action)
to automate versioning. Write commits in the
[conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)
style (e.g. `fix: annoying bug` or `feat(ui): add new buttons`),
and release-please creates a pull request with the next version.
When we merge that PR, a tag and a GitHub release are created.

Create `.github/workflows/release-please.yml`:

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

The workflow uses a `${{ secrets.PAT }}` repository secret so that the publish
workflow (which we'll set up next) can be triggered by the release.
Let's generate that token.

### Generating a PAT (Personal Access Token)


1. Navigate to our Account -> Settings.

   ![settings](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/52cce7d0-b53c-467f-a3d9-a1bd6a1e1614)

2. Navigate to "Developer Settings" at the bottom of the Settings tab.

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/0452ab2a-3f2f-4162-a8f4-411ba6bd2f37)

3. Go to Personal Access Tokens -> Tokens (classic).

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/863a5358-551c-4f44-b31b-85bb906cbc21)

4. Generate a new classic token.

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/72693b75-1a65-4bb7-8e01-bb256aa4db15)

5. Modify the highlighted sections to the values shown on screen.

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/534f49a0-d46d-422e-9c29-92d6f54dd640)

6. Press "Generate Token"!

7. **Copy our PAT to the same place where we stored our LuaRocks API key in the previous chapter**.

   ![image](https://github.com/nvim-neorocks/sample-luarocks-plugin/assets/76052559/46c8d326-5534-447e-9268-670b872e3144)


### Adding our secrets to GitHub

1. Navigate to our GitHub repository and enter its settings.

   ![image](https://github.com/vhyrro/sample-luarocks-plugin/assets/76052559/3fab5791-189f-42cb-b8b2-824af45a114d)

2. In the settings go to `Security > Secrets and variables > Actions`.

   ![image](https://github.com/vhyrro/sample-luarocks-plugin/assets/76052559/ab8ca077-3f8a-4263-9583-2abcebdf9e6a)

3. Create a `LUX_API_KEY` secret with the API key from the publishing chapter.

   ![image](https://github.com/vhyrro/sample-luarocks-plugin/assets/76052559/a67ddd29-5021-4d45-ae74-8a40507ccc51)

   ![image](https://github.com/vhyrro/sample-luarocks-plugin/assets/76052559/48590516-cf03-43a4-9ded-575c5a63caf5)

4. Create a `PAT` secret with the Personal Access Token we copied earlier.
5. Create a `LUAROCKS_2FA_SECRET` secret with the 2FA secret key from the
   [publishing chapter](./08-publishing.md#two-factor-authentication-2fa).

:::important
Make sure each secret name is spelled exactly as shown above.
:::

### Publishing to LuaRocks

Create `.github/workflows/publish.yml`:

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
          LUAROCKS_2FA_SECRET: ${{ secrets.LUAROCKS_2FA_SECRET }}
```

## Publishing a release

Let's merge the release-please pull request. A minute later, we should see:

1. A new GitHub release with a version tag in our repository.
2. The publish workflow running in the Actions tab.
3. Our package appearing on [`luarocks.org`](https://luarocks.org).

Head to [luarocks.org](https://luarocks.org) and search for our package to confirm.

## Troubleshooting

### I already merged the release-please PR

We can trigger the publish workflow manually:

```sh
gh workflow run publish.yml
```

After a minute, our package should appear on luarocks.org.
