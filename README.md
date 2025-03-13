# Alpha :⚡ A fast cheatsheet for the alphabet written in assempbly

## Test it

```bash
nix run github:NewDawn0/alpha
```

## Installation

1. Add it to your flake

```nix
{
    inputs.alpha.url = "github:NewDawn0/alpha";
    # ...
    pkgs = import nixpkgs {
        # ...
        overlays = [ alpha.overlays.default ];
    };
}
```

2. Add it to your packages

```nix
environment.systemPackages = with pkgs; [ alpha ];
```
