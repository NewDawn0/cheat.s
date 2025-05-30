{
  description = "TUI cheat utility, optimized for forgetfulness";

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
    packages = utils.lib.eachSystem { } (pkgs: {
      default = pkgs.stdenv.mkDerivation {
        name = "cheat";
        version = "2.0.2";
        src = ./.;
        nativeBuildInputs = with pkgs; [ autoconf gnumake nasm patch ];
        configurePhase = ''
          autoconf -i
          ./configure
          make patch
        '';
        buildPhase = "make build";
        installPhase = "install -D cheat $out/bin/cheat";
        meta = with pkgs.lib; {
          description = "TUI cheat utility, optimized for forgetfulness";
          homepage = "https://github.com/cheat/cheat";
          license = licenses.mit;
          platforms = platforms.all;
        };
      };
    });
  };
}
