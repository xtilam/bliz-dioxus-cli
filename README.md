<div>
  <h1>📦✨ Dioxus CLI</h1>
  <p><strong>Tooling to supercharge Dioxus projects</strong></p>
</div>

The **dioxus-cli** (inspired by wasm-pack and webpack) is a tool for getting Dioxus projects up and running.
It handles building, bundling, development and publishing to simplify development.

## Installation

### Install from git

```shell
cargo install --git https://github.com/xtilam/bliz-dioxus-cli --tag v0.17.10-rcx
```

This will download the CLI at the `v0.17.10-rcx` tag,
and install it in Cargo's global binary directory (`~/.cargo/bin/` by default).

### Install from local folder
Note: The CLI will fail to build projects in debug profile. This is currently under investigation.
```shell
cargo install --path .
```

## Get started

Use `dx new` to initialize a new Dioxus project.
It will be cloned from the [dioxus-template](https://github.com/DioxusLabs/dioxus-template) repository.

Alternatively, you can specify the template path:

```shell
dx new --template gh:dioxuslabs/dioxus-template
```

Run `dx --help` for a list of all the available commands.
Furthermore, you can run `dx <command> --help` to get help with a specific command.

## Dioxus config file

You can use the `Dioxus.toml` file for further configuration.
Some fields are mandatory, but the CLI tool will tell you which ones are missing.
You can create a `Dioxus.toml` with all fields already set using `dx config init project-name`,
or you can use this bare-bones template (only mandatory fields) to get started:

```toml
[application]
name = "project-name"
# Currently supported platforms: web, desktop
default_platform = "web"

# Optional: enable copying from a static directory (e.g. "public")
public_dir = "public"

[web.app]
title = "Hello"

[web.resource.dev]
```
