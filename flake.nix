{
  description = "Fast cheatsheets for random stuff";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils = {
      url = "github:NewDawn0/nixUtils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, utils, ... }: {
    overlays.default = final: prev: {
      cheat = self.packages.${prev.system}.default;
    };
    packages = utils.lib.eachSystem { } (pkgs:
      # TODO: Linux patch
      # TODO: Linux build
      {
        default = pkgs.stdenv.mkDerivation {
          name = "cheat";
          version = "2.0.1";
          src = ./.;
          nativeBuildInputs = with pkgs; [ autoconf gnumake nasm patch ];
          configurePhase = "autoconf -i && ./configure";
          buildPhase = "make build";
          installPhase = "install -D cheat $out/bin/cheat";
        };
      });
  };
}
