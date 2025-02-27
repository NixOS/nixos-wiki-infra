{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-e8624ce.tar.gz/MobileFrontend-REL1_42-e8624ce.tar.gz";
    hash = "sha256-57LYb3K/k2dSL4Hm5CFjkA1JKFZWG7idqxBovoN5GJs=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-9ef9ab5.tar.gz/Translate-REL1_42-9ef9ab5.tar.gz";
    hash = "sha256-iER0XPeneptnIlKdzYMJs6OMfg5BkCawyWmJxCk8Fig=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-f805c9d.tar.gz/UniversalLanguageSelector-REL1_42-f805c9d.tar.gz";
    hash = "sha256-997n6ak4IEBUmLIU47KFCQxhTCqeVK6UQZzOCudtPGw=";
  };
}
