{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_44-145ff3a.tar.gz/MobileFrontend-REL1_44-145ff3a.tar.gz";
    hash = "sha256-OoS54VKgRcyVUB251J1tlhPv0E63L9d22lx1Q6PoMW4=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_44-aa07662.tar.gz/DarkMode-REL1_44-aa07662.tar.gz";
    hash = "sha256-C7x5LRBvLWA9DEA8yUpNCSH60H30FZmSY7yZhbMVZQM=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_44-004f271.tar.gz/QuickInstantCommons-REL1_44-004f271.tar.gz";
    hash = "sha256-KZlHoOnr8TWZ1yIujq+DT2qiajB5JCseS9mBY2jDSvM=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_44-af8cc0b.tar.gz/Translate-REL1_44-af8cc0b.tar.gz";
    hash = "sha256-gHg1LUVqwfr7ZMyS0PhXn7Mho1p9wkoZCPScn6yrM9I=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_44-ad955c2.tar.gz/UniversalLanguageSelector-REL1_44-ad955c2.tar.gz";
    hash = "sha256-3EySpp1agCws+BOs94bvToZ7xfBVVhAeNUOHVM2vLJk=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_44-c01810f.tar.gz/Description2-REL1_44-c01810f.tar.gz";
    hash = "sha256-aAjFcrOAz5wDyfC+wv4paIaZ09wDEsQaCHRdddG5oOs=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.3/AuthManagerOAuth.zip";
    hash = "sha256-xReQzh/ZcQsOD/qb3iqbgSeNOh+7pE6d7h6Sc/aHyTw=";
  };
}
