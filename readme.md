# dotfiles

A home for my workstation configs and setup

## Installation

1. Install Nix:

```sh
sh <(curl -L https://nixos.org/nix/install)
```

Again, if you have any issue, consult [official website](https://nixos.org/download/).

2. Copy nix configs to enable Flakes:

```sh
sudo cp ./nix/nix.conf /etc/nix/nix.conf
```

3. Install nix-darwin:

```sh
nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch
```

4. Run system rebuild

```sh
darwin-rebuild switch --flake .#macbook-pro
```
