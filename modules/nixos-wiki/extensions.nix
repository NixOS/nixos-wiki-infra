{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-8be3738.tar.gz/MobileFrontend-REL1_42-8be3738.tar.gz";
    hash = "sha256-Af6Q2WbeIJC0/VUNLz9Oo7TU0biwhmFzgeB9pP2+17o=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-cc1aecb.tar.gz/Translate-REL1_42-cc1aecb.tar.gz";
    hash = "sha256-gNXntGH4FVpbqaG0qO0OJTXMaltSqBHLGJtKxdPxU/8=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-10f51fe.tar.gz/UniversalLanguageSelector-REL1_42-10f51fe.tar.gz";
    hash = "sha256-ykyh+jSh0oo3PPEdTa1apZgzIwLBOtOs5wBQq+c1Mww=";
  };
}
