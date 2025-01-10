{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-beb8cf1.tar.gz/MobileFrontend-REL1_42-beb8cf1.tar.gz";
    hash = "sha256-BXmpWY7YBVfbgUJ1+bBoAn7f5NuL6ayHJIgb6HtbTeI=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-437f77b.tar.gz/Translate-REL1_42-437f77b.tar.gz";
    hash = "sha256-BswcwBEDehVEdbcdVOpg+ij/tOik4GTdS7TvVfjnzjY=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-9ddd94d.tar.gz/UniversalLanguageSelector-REL1_42-9ddd94d.tar.gz";
    hash = "sha256-dVNCLa3l2JuPI69HMBNQLeVqpfLn+xMeylQ39ly+QXg=";
  };
}
