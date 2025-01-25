{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-2c61ed7.tar.gz/MobileFrontend-REL1_42-2c61ed7.tar.gz";
    hash = "sha256-3pfzahtAKxaCqGTpyKSHZvbKHu3J+bz++1G7odZ39tk=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-ef95c1c.tar.gz/Translate-REL1_42-ef95c1c.tar.gz";
    hash = "sha256-wgF3VDB2V3pi3A0ivXuYb8sf3FmJe/sBH7Ts4AYKgDc=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-6d5466d.tar.gz/UniversalLanguageSelector-REL1_42-6d5466d.tar.gz";
    hash = "sha256-lTOwu4CfkocQVvFtmAqmv0rftywQoEgRPjeSELRXYPs=";
  };
}
