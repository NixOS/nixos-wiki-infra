{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-a75edea.tar.gz/MobileFrontend-REL1_43-a75edea.tar.gz";
    hash = "sha256-uFAIdsKmklQE5sy0YyaShJt5+UOWQUHnRJXCVTKWX1w=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_43-c1b6238.tar.gz/DarkMode-REL1_43-c1b6238.tar.gz";
    hash = "sha256-QKPrSHb7JA3MDdCQX13bccDd0mxCJWCS8a2XGolKOys=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_43-1a1b0c9.tar.gz/QuickInstantCommons-REL1_43-1a1b0c9.tar.gz";
    hash = "sha256-pdP31HGwJpwbjNoRMyStLTOcucsnlIpyD09JNuUV08w=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-c0fc074.tar.gz/Translate-REL1_43-c0fc074.tar.gz";
    hash = "sha256-kLUb6NKcN3lt1dymBKzlZUwAYWquElsfuZfGjNlQO8Y=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-9d1b249.tar.gz/UniversalLanguageSelector-REL1_43-9d1b249.tar.gz";
    hash = "sha256-obGraqzj7C8gDvF4B8p9AV8cEuPNo1g8iiR7yLt+2Os=";
  };
}
