{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-cea59dc.tar.gz/MobileFrontend-REL1_43-cea59dc.tar.gz";
    hash = "sha256-DajUC8qIRjAdrwmvoWV78tepS8FE6Q6DFoP6NcQUA48=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-32bf327.tar.gz/Translate-REL1_43-32bf327.tar.gz";
    hash = "sha256-mjFupMgawwhtSXidS/cI4+xUz6rW0gxe0ODixFs/JNM=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-5be4d43.tar.gz/UniversalLanguageSelector-REL1_43-5be4d43.tar.gz";
    hash = "sha256-bcVe2tCE6IF2xjFe+PGb8riYb3zYmZc53mqqNwP9Nyk=";
  };
}
