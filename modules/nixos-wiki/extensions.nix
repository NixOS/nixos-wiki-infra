{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-41d4601.tar.gz/MobileFrontend-REL1_42-41d4601.tar.gz";
    hash = "sha256-0UEwfNDiy1q2Tt/HmGHCEeoj9cJ96pC0ZZa4d5nCKtg=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-bdc73d2.tar.gz/Translate-REL1_42-bdc73d2.tar.gz";
    hash = "sha256-o4zy9EGYOPOZ8k+qZGB0lugMwO/Dk5uuMskPhPcEoHo=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-8560f70.tar.gz/UniversalLanguageSelector-REL1_42-8560f70.tar.gz";
    hash = "sha256-pzH7IyBIHUEiF+LkdoP6mtLji9sk8cBAaYVcQMpCb1A=";
  };
}
