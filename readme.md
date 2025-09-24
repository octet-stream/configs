# configs

A home for my workstation configs and setup

## Installation

1. Install Nix:

```sh
sh <(curl -L https://nixos.org/nix/install)
```

If you have any issue, please refer to [official documentation](https://nixos.org/download/).

2. Install nix-darwin & first system rebuild:

```sh
nix --extra-experimental-features "nix-command flakes" run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch --flake .#macbook-pro
```

This command will run `darwin-rebuild switch` to setup the configuration for `macbook-pro` host.

## System rebuild

There are 3 ways you can rebuild your system, but they're all equivalent:

```sh
darwin-rebuild switch --flake .#macbook-pro
```

This command will build nix-darwin configuration for `macbook-pro` host.

Note that you **must** provide `--flake` flag either if you run the command outside of the configs root, or if hostname of your machine is different.

or using `nh`

```sh
nh darwin switch
```

or via custom alias for previous command

```sh
mac-rebuild
```

Both `nh` and `mac-rebuild` can be executed outside of the configs root without explicit path to the flake,
because they will look at `$NH_FLAKE` environment variable to determine the path.
This variable will be set on your first system rebuild.

### Updating flake inputs

To update flake inputs use following command:

```sh
mac-up
```

or (in configs root)

```sh
nix flake update
```

Both these commands will bump your `flake.lock` file, and you can rebuild your system once the process is completed.

Optionally you can provide a path to flake via `--flake` flag

## Caveats

Here's a list of problems you may encounter with some of the components:

1. Many OS's don't have terminfo for ghostty by default, so you'll need to add it manually: https://ghostty.org/docs/help/terminfo#ssh
