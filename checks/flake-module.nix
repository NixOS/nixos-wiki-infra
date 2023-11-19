{ self, ... }: {
  perSystem =
    { pkgs
    , lib
    , ...
    }: {
      checks = lib.optionalAttrs pkgs.stdenv.isLinux {
        test = import ./test.nix { inherit self pkgs; };
      };
    };
}
