{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-aca984e.tar.gz/MobileFrontend-REL1_43-aca984e.tar.gz";
    hash = "sha256-8V6jHMF6GeoBoWrqx1G/sSDYOjHzcJl1OHc88WzNLxM=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-dd979b6.tar.gz/Translate-REL1_43-dd979b6.tar.gz";
    hash = "sha256-Hlp08TSDfqFe8dwY/JGVcpUJUZ5pmmflM1IB0jpg560=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-2275fe3.tar.gz/UniversalLanguageSelector-REL1_43-2275fe3.tar.gz";
    hash = "sha256-Th7rXDRn36LobvzKDFEO1MRrkAU5Lvad0UiOwlTdzzQ=";
  };
}
