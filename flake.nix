{
  description = "Fast alphabet cheatsheet";

  inputs = {
    utils.url = "github:NewDawn0/nixUtils";
    translate = {
      url = "github:NewDawn0/translate";
      inputs.utils.follows = "utils";
    };
  };

  outputs = { self, translate, utils, ... }: {
    overlays.default = final: prev: {
      alpha = self.packages.${prev.system}.default;
    };
    packages =
      utils.lib.eachSystem { overlays = [ translate.overlays.default ]; } (pkgs:
        # TODO: Linux patch
        # TODO: Linux build
        {
          default = pkgs.stdenv.mkDerivation {
            name = "alpha";
            version = "1.0.0";
            src = ./.;
            nativeBuildInputs = with pkgs; [ autoconf nasm gnused ];
            configurePhase = "autoconf -i && ./configure";
            buildPhase = "make build";
            installPhase = "install -D alpha $out/bin/alpha";
          };
        });
  };
}
