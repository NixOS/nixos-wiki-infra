{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-23daf6a.tar.gz/MobileFrontend-REL1_42-23daf6a.tar.gz";
    hash = "sha256-qmLo0EizZtAxbdcwxhNCgfeYsNChKAvVnSlcfJI83bQ=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-5e9904b.tar.gz/Translate-REL1_42-5e9904b.tar.gz";
    hash = "sha256-siVxwNFBL/f7Ba63Yy5bMeiGbGw1N4y51ha9xKJvLwE=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-1301eea.tar.gz/UniversalLanguageSelector-REL1_42-1301eea.tar.gz";
    hash = "sha256-G9PpkUCzk8aN8zU51tQtb/O8PUdSU8pDpPVw2x1yqAA=";
  };
}
