<div>
  <h1>📦✨ Dioxus CLI</h1>
  <p><strong>Tooling to supercharge Dioxus projects</strong></p>
</div>

The **dioxus-cli** (inspired by wasm-pack and webpack) is a tool for getting Dioxus projects up and running.
It handles building, bundling, development and publishing to simplify development.

## Installation

### Install from git

```shell
cargo install --git https://github.com/xtilam/bliz-dioxus-cli --tag v0.17.10-rc3
```

This will download the CLI at the `v0.17.10-rc3` tag,
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

## Added CLI flags

This fork adds two flags to `dx serve`. Both are also accepted by `dx run`, which forwards the
`dx serve` arguments.

### `--hot-patch-rsx`

Hot-patch code inside `rsx!` macros through the Rust hot-patch engine.

- Implies `--hot-patch` and disables RSX template hot-reloading.
- Every change to a `.rs` file is sent to the hot-patch engine, including code inside `rsx!`.
  The CLI no longer splits changes into an "RSX-only" template diff that a client would apply.
- Useful for `dioxus-native` targets, which have no browser client to receive RSX template
  hot-reloads.

```shell
dx serve --hot-patch-rsx
```

### `--inherit-stdio`

Give the app process the terminal's stdin, stdout, and stderr.

- The app can read from stdin and writes directly to the terminal, which is useful for
  interactive or long-running apps.
- While the app runs, the CLI buffers its own log output in memory and flushes it when the app
  exits.
- The TUI is disabled while the app owns the terminal and is reclaimed once the app exits.
- Supported for desktop and server targets. It is ignored for web, iOS, and Android, where the app
  does not run as a local process.

```shell
dx serve --inherit-stdio
```

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
