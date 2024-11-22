{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-4dcf2bc.tar.gz/MobileFrontend-REL1_42-4dcf2bc.tar.gz";
    hash = "sha256-tywOVqTdj1dW28sIAaH2+VCYZsJxzv+5dE0/LdQ/DvM=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_42-66aad97.tar.gz/DarkMode-REL1_42-66aad97.tar.gz";
    hash = "sha256-xt7+yiD2oDsK0q7tsqAtYdiKcLqWr8DiWl+zAmoqQpg=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_42-3e6a069.tar.gz/QuickInstantCommons-REL1_42-3e6a069.tar.gz";
    hash = "sha256-U7mNjhr0kI46gWForiUBKXQEYSuvME8+YVwMOVpuhm0=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-0497719.tar.gz/Translate-REL1_42-0497719.tar.gz";
    hash = "sha256-asqsprXSCfVfMG9jACy/LIMsP0rWZJv8jbRFrGj2om0=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-35e3adb.tar.gz/UniversalLanguageSelector-REL1_42-35e3adb.tar.gz";
    hash = "sha256-V9V0tURGdHfqih6olXSLAxR7Q9QWt0BJIFCHUl/Nf1c=";
  };
}
