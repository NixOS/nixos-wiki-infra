{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-03fed6b.tar.gz/MobileFrontend-REL1_42-03fed6b.tar.gz";
    hash = "sha256-twHJVZRQe2XW4XSx3QQNbgbo1DROj8+mjjea9Fr35is=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-a26104a.tar.gz/Translate-REL1_42-a26104a.tar.gz";
    hash = "sha256-ksMqGYwUZaQjR/MLUcbF0c+ZhBMfVUcdae+u8O0X/Hs=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-9778483.tar.gz/UniversalLanguageSelector-REL1_42-9778483.tar.gz";
    hash = "sha256-m6kTv3ZgynlawCZp7b81ufQveetxsiWntgCZZmADHIo=";
  };
}
