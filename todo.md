# TODOs

## Diataxis

Follow diataxis framework:
Create tutorials, guides etc.

## Subdomains?

Patching the documentation to exist under `/rust-doc` is very bloody difficult
but we have to figure it out (mostly because the links aren't relative and
backflip whenever it feels like it). We could make a subdomain but that'll end
up being complicated if we use github pages.

# General Plans

Make tutorial on how to develop a CLI app using rocks.

- [x] Introduction
- [x] Getting started
- [x] Creating a Project
- [x] Adding Dependencies
- [x] Making the CLI application
- [ ] Testing the application
- Preparing our code
    - Formatting the current document
    - Running `luacheck`
- Publishing to `luarocks.org`
    - Setting up an API key
    - Running `rocks upload`
