{
  pkgs ? import <nixpkgs> { },
}:
{
  wikiextractor = pkgs.callPackage ./wikiextractor.nix { };
}
