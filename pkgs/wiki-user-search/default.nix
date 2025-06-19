{
  lib,
  psycopg2,
  buildPythonApplication,
}:

buildPythonApplication {
  pname = "wiki-user-search";
  version = "1.0.0";

  src = ./.;

  format = "other";

  propagatedBuildInputs = [ psycopg2 ];

  installPhase = ''
    runHook preInstall

    install -Dm755 wiki-user-search.py $out/bin/wiki-user-search

    runHook postInstall
  '';

  meta = with lib; {
    description = "MediaWiki user search tool with fuzzy matching";
    homepage = "https://github.com/NixOS/nixos-wiki-infra";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "wiki-user-search";
  };
}
