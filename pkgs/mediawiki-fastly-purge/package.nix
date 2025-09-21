{
  lib,
  stdenv,
}:

stdenv.mkDerivation {
  pname = "mediawiki-fastlypurge";
  version = "1.0.0";

  src = ./.;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r * $out/

    runHook postInstall
  '';

  meta = with lib; {
    description = "MediaWiki extension for Fastly CDN cache purging";
    homepage = "https://github.com/NixOS/nixos-wiki-infra";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
