# NIX FLAKES

My personal SwayWM config written with NixOs.

## How to update if all software is fixed?
1. Update all the tags in the `flake.lock` file with:
```bash
nix flake update
```

2. Update the system with:
```bash
sudo nixos-rebuild switch --cores 4 --flake ".#laptop" --upgrade
```
