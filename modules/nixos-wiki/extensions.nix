{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_44-33afaab.tar.gz/MobileFrontend-REL1_44-33afaab.tar.gz";
    hash = "sha256-SHH9Z0753oytU6exBwW/P0U67YDTYH4fqz9pf4ak5Ow=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_44-48cda65.tar.gz/DarkMode-REL1_44-48cda65.tar.gz";
    hash = "sha256-gVY7ip2tAVT5WPyy1T1+4r9JiOqEkS5xOOA2W7PE3nc=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_44-004f271.tar.gz/QuickInstantCommons-REL1_44-004f271.tar.gz";
    hash = "sha256-KZlHoOnr8TWZ1yIujq+DT2qiajB5JCseS9mBY2jDSvM=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_44-58c3e58.tar.gz/Translate-REL1_44-58c3e58.tar.gz";
    hash = "sha256-0pL6vyjv6bAzoU1NhSZDS/c6vRs9SzSe4rJBn8vHO/A=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_44-fc09a60.tar.gz/UniversalLanguageSelector-REL1_44-fc09a60.tar.gz";
    hash = "sha256-eWtLoA6S/u3Ouw6QANjz3kqbR3R2Dwhs6nS70jaD/eA=";
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
