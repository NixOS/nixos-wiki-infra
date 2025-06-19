{ pkgs }:

{
  wiki-user-search = pkgs.python3.pkgs.callPackage ./wiki-user-search { };
}
