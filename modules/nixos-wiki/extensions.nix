{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-9de9f8b.tar.gz/MobileFrontend-REL1_43-9de9f8b.tar.gz";
    hash = "sha256-J6MaW4W+b5jYIvUO+vnnX1OlCg8lCk3TrruoW6D9iIA=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-c78464b.tar.gz/Translate-REL1_43-c78464b.tar.gz";
    hash = "sha256-zqudo18Iuh28+dwaaR2ZMiDf3Nbi8Mf0TueVWlsBUHg=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-f6847ba.tar.gz/UniversalLanguageSelector-REL1_43-f6847ba.tar.gz";
    hash = "sha256-D7zqnzmnYMhARO4+pAU3QrDmmTaJPiBPvNaWj4wEPRI=";
  };
}
