{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-8657ce1.tar.gz/MobileFrontend-REL1_43-8657ce1.tar.gz";
    hash = "sha256-E3OGD1CjCxmI1v+zZ6g93qA78d/WXJi3fag6pYyL1mk=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-ced85d4.tar.gz/Translate-REL1_43-ced85d4.tar.gz";
    hash = "sha256-a2QKtXneOSc0Xiyn6+104qiLSnyy7pWuUKqujKYzkTw=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-4e8a076.tar.gz/UniversalLanguageSelector-REL1_43-4e8a076.tar.gz";
    hash = "sha256-PAGEB1FiInWRQLjubRiCHNm+EZupuic1/5g+5nCnxek=";
  };
}
