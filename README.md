# Lux Documentation Site

This is the source code for the [Lux Documentation Site](https://lux.lumen-labs.org/).

## Contributing

This project uses the [Diátaxis](https://diataxis.fr/) framework.
Before contributing, read its description of each dimension to understand
the distinctions between tutorials, how-to guides, explanations, and reference.

### Set up a development environment

```sh
nix develop .#
```

If you use [nix-direnv](https://github.com/nix-community/nix-direnv):

```sh
echo "use flake .#" > .envrc && direnv allow
```

### Preview documentation

```sh
bun run build
```

This builds the site with Docusaurus. Open `build/` in a browser or use
`bun run start` for hot reload.

### Add a how-to guide

1. Create a new `.md` file in `docs/guides/`.
2. Write in imperative mood. Start each step with a verb.
3. Minimise commentary. Do not explain concepts — link to explanations or reference instead.
4. Address a single, practical goal (e.g. "How to add a dependency").
5. Add a `---` id in the front matter that matches the file name (without extension).
6. Register the guide in `sidebars.js` under the `guides` category.

### Add a tutorial

1. Create a new `.md` file in `docs/tutorial/`.
2. Assume no prior knowledge of the tool. Write step-by-step from start to finish.
3. Unlike how-to guides, tutorials may explain and contextualise as the user progresses.
4. Keep the scope narrow enough for a newcomer to follow in one sitting.
5. Register in `sidebars.js` under the `tutorial` category.

### Add an explanation

1. Create a new `.md` file in `docs/explanations/`.
2. Answer "why?" questions. Discuss trade-offs, alternatives, and rationale.
3. Do not write step-by-step procedures or reference material.
4. Register in `sidebars.js` under the `explanations` category.

### Add reference material

1. Create a new `.md` file in `docs/reference/`.
2. Be accurate and complete. Describe what exists, not how to use it.
3. Prefer generation from source (man pages, schemas) over hand-written docs.
4. Register in `sidebars.js` under the `reference` category.

Some files are auto-generated.
Look out for comments at the top indicating they should not be edited by hand.

### Type-check the scripts

```sh
pushd scripts && lx check --warnings-as-errors && popd
```

This validates LuaCATS type annotations and code style in `scripts/src/`.

### Submit changes

1. Write commit messages using [Conventional Commits](https://www.conventionalcommits.org/).
   For documentation changes, use the `docs:` prefix
   (e.g. `docs: add guide for multi-project workspaces`).
2. Make changes. Follow the dimension-specific guidance above.
3. Verify the build succeeds: `bun run build`
4. Open a pull request. In the description, note which Diátaxis dimension(s) the change targets.
