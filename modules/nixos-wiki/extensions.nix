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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-efa02be.tar.gz/Translate-REL1_42-efa02be.tar.gz";
    hash = "sha256-Avi/X+ZCyTGtpV4GuYC8nBGeEElsnf1Bida1wiTp6xs=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-cc0c7ac.tar.gz/UniversalLanguageSelector-REL1_42-cc0c7ac.tar.gz";
    hash = "sha256-mMd3HeTOeGa7uHkSfP9M2i/M5NpAkmUXx8PiZsvIeXM=";
  };
}
