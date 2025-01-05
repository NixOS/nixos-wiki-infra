{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-52c9433.tar.gz/MobileFrontend-REL1_42-52c9433.tar.gz";
    hash = "sha256-MjvZYCOaXPdvGCTZIlTXd+O7rukuptWBiIBVizdLLWE=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-7f1dd7c.tar.gz/Translate-REL1_42-7f1dd7c.tar.gz";
    hash = "sha256-A5fZjYA/7+KCtE8fOaNVvnIBPajw3MvpaqKGUnx/yM0=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-ec683c8.tar.gz/UniversalLanguageSelector-REL1_42-ec683c8.tar.gz";
    hash = "sha256-Hrt/CzDCjhZlE9MyNEKJJVLmuvHIel7pmjejRxqrj9A=";
  };
}
