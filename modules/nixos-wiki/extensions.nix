{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-12472d6.tar.gz/MobileFrontend-REL1_42-12472d6.tar.gz";
    hash = "sha256-TJyLAwfqtoyNXTJzh51DLqaBnvwXPn+Yod5YQxEThB0=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-a0cab45.tar.gz/Translate-REL1_42-a0cab45.tar.gz";
    hash = "sha256-tfLs3+5BscM0wk9H8G4AeuhKKSSm47uNRmoU9l7075Y=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-bf703d0.tar.gz/UniversalLanguageSelector-REL1_42-bf703d0.tar.gz";
    hash = "sha256-ofpYL8o44YWA9v9OELOl0rL8fyRcaOytNEITMCgh7ts=";
  };
}
