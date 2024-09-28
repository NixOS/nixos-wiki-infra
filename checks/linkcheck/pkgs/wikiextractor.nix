{
  lib,
  python3,
  fetchpatch,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "wikiextractor";
  version = "3.0.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "attardi";
    repo = "wikiextractor";
    rev = "v${version}";
    hash = "sha256-QeBC6ACHGKCSegd+wnOyIZI93L+f1EU62sFE0sAEwhU=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  pythonImportsCheck = [
    "wikiextractor"
  ];

  patches = [
    # https://github.com/attardi/wikiextractor/issues/336#issuecomment-2322886454
    (fetchpatch {
      url = "https://github.com/attardi/wikiextractor/commit/ab8988ebfa9e4557411f3d4c0f4ccda139e18875.patch";
      hash = "sha256-K1N6BA3FLieBTMIg9fyavc9ZajAr0vs754Nox53htmY=";
    })
  ];

  meta = {
    description = "A tool for extracting plain text from Wikipedia dumps";
    homepage = "https://github.com/attardi/wikiextractor";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ phanirithvij ];
    mainProgram = "wikiextractor";
  };
}
