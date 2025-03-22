{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-3b4cac8.tar.gz/MobileFrontend-REL1_43-3b4cac8.tar.gz";
    hash = "sha256-aJOArZl+oO/ADjxIhlFVGS8hGmpSp6nsgC7XkKEk1Ks=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-cb93cd8.tar.gz/Translate-REL1_43-cb93cd8.tar.gz";
    hash = "sha256-UwLrfIGEqE2TXve12pVcGrdCiytaDNoABU1ZTclM8og=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-b9b99e4.tar.gz/UniversalLanguageSelector-REL1_43-b9b99e4.tar.gz";
    hash = "sha256-gfP7Q8deDq/J/kYCUH1eIDgGDBug/IcZo94tLeuAOmM=";
  };
}
