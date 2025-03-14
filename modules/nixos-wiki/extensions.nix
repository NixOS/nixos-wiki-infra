{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-7172e23.tar.gz/MobileFrontend-REL1_42-7172e23.tar.gz";
    hash = "sha256-ACkYxPHmaajBTnCk/vLLv6v1cVkxhOulrrGmSJ94EM0=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-16e1b16.tar.gz/Translate-REL1_42-16e1b16.tar.gz";
    hash = "sha256-c5XSy2lUwrWBpg9BEj0AaGl/8Wt3UsRLjySLMpKSX/o=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-6ddacd9.tar.gz/UniversalLanguageSelector-REL1_42-6ddacd9.tar.gz";
    hash = "sha256-FWCLG971QmB4GcWLyMpIymrvL/ECrbboo7hlvuKqPd4=";
  };
}
