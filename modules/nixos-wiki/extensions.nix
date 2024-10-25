{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-8a4ecb7.tar.gz/MobileFrontend-REL1_42-8a4ecb7.tar.gz";
    hash = "sha256-oxc8HU0yjjKCKIbGIJTYQ0VoowTFqqYT/LBNJKO2gyQ=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-489f848.tar.gz/Translate-REL1_42-489f848.tar.gz";
    hash = "sha256-Hd8WyxSjDkovSfDJxLEiqM+oaFPlt9kW+tvlQ1gu36M=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-d26724a.tar.gz/UniversalLanguageSelector-REL1_42-d26724a.tar.gz";
    hash = "sha256-O+0sYcOV61ZoTg7Z31ag38Vm77IAuixu7/NMftRh+X4=";
  };
}
