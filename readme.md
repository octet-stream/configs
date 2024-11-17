# dotfiles

A home for my workstation configs and setup

## Installation

1. Install Rosetta (if not installaed, you can also skip this step if you don't need x84_64 support):

```sh
softwareupdate --install-rosetta --agree-to-license
```

2. Install developer tools:

```sh
xcode-select --install
```

3. Install Homebrew:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

If you have any issues with the installation, you can follow instructions on the [official website](https://brew.sh/).

4. Install Nix:

```sh
sh <(curl -L https://nixos.org/nix/install)
```

Again, if you have any issue, consult [official website](https://nixos.org/download/).

5. Copy nix configs to enable Flakes:

```sh
sudo cp ./nix/nix.conf /etc/nix/nix.conf
```
