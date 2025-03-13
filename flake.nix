{
  description = "Fast alphabet cheatsheet";

  inputs.utils.url = "github:NewDawn0/nixUtils";

  outputs = { self, utils, ... }: {
    overlays.default = final: prev: {
      alpha = self.packages.${prev.system}.default;
    };
    packages = utils.lib.eachSystem { } (pkgs:
      let
        sharedAttrs = {
          name = "alpha";
          version = "0.0.1";
          src = ./.;
          buildInputs = with pkgs; [ nasm ];
          installPhase = "install -D alpha $out/bin/alpha";
          meta = {
            description = "Fast alphabet cheatsheet";
            longDescription =
              "Useful to quickly look up the alphabetical order when sorting items manually in alphabetical order";
            homepage = "github:NewDawn0/alpha";
            license = pkgs.lib.licenses.mit;
            maintainers = with pkgs.lib.maintainers; [ NewDawn0 ];
          };
        };
        darwinBld = {
          patchPhase = "";
          buildPhase = ''
            nasm -fmacho64 -o alpha.o src/alpha.asm
            ld -lSystem -L$(xcrun --show-sdk-path)/usr/lib -o alpha alpha.o
          '';
        };
        linuxBld = {
          patchPhase = "patch src/alpha.asm < patches/linux.patch";
          buildPhase = ''
            nasm -felf64 -o alpha.o src/alpha.asm
            ld -o alpha alpha.o
          '';
        };
      in {
        default = pkgs.stdenv.mkDerivation {
          inherit (sharedAttrs) name version src buildInputs installPhase meta;
          patchPhase = with pkgs;
            lib.optionalString stdenv.hostPlatform.isDarwin darwinBld.patchPhase
            + lib.optionalString stdenv.hostPlatform.isLinux
            linuxBld.patchPhase;
          buildPhase = with pkgs;
            lib.optionalString stdenv.hostPlatform.isDarwin darwinBld.buildPhase
            + lib.optionalString stdenv.hostPlatform.isLinux
            linuxBld.buildPhase;
        };
      });
  };
}
