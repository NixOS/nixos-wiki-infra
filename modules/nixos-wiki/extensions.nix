{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-ef67cbd.tar.gz/MobileFrontend-REL1_42-ef67cbd.tar.gz";
    hash = "sha256-R233mgiIBHBhs/E6H/FhuyDIgE0zYc4l1vBHTe6+95g=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-5454dda.tar.gz/Translate-REL1_42-5454dda.tar.gz";
    hash = "sha256-eSBetYlffdS6/MBlZS/pfoPnwx/6BZZavw89CQf08as=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-f81ad7e.tar.gz/UniversalLanguageSelector-REL1_42-f81ad7e.tar.gz";
    hash = "sha256-qm5lDtkbPYD7jBNHhbdADIjGlOfXKSJ4BJNbkxdSJ2w=";
  };
}
