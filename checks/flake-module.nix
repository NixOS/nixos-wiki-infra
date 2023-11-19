{ self, ... }: {
  perSystem =
    { pkgs
    , ...
    }: {
      checks =
        let
          # this gives us a reference to our flake but also all flake inputs
          checkArgs = { inherit self pkgs; };
        in
        {
          test = import ./test.nix checkArgs;
        };
    };
}
