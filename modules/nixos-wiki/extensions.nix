{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-8aca9fe.tar.gz/MobileFrontend-REL1_43-8aca9fe.tar.gz";
    hash = "sha256-Pn5PGka8KqjC8/p1UZSTtu++ib0lNVSbmDQ5Y4lxP3I=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_43-c1b6238.tar.gz/DarkMode-REL1_43-c1b6238.tar.gz";
    hash = "sha256-QKPrSHb7JA3MDdCQX13bccDd0mxCJWCS8a2XGolKOys=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_43-3330ce1.tar.gz/QuickInstantCommons-REL1_43-3330ce1.tar.gz";
    hash = "sha256-JVNHE4hQD+gk/ber728QJck2OS76jaHEyVWr45+P/HI=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-a68b907.tar.gz/Translate-REL1_43-a68b907.tar.gz";
    hash = "sha256-p3lufU4ZHzIazIK9FVeefVgq1qN8VGAgpn/SDw357jc=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-4e8a076.tar.gz/UniversalLanguageSelector-REL1_43-4e8a076.tar.gz";
    hash = "sha256-PAGEB1FiInWRQLjubRiCHNm+EZupuic1/5g+5nCnxek=";
  };
}
