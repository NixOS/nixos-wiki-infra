{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_44-bc93b54.tar.gz/MobileFrontend-REL1_44-bc93b54.tar.gz";
    hash = "sha256-AlitMcu/f8Q9/lqdfzdT8r+i4lPaU4Nzyaj573hscSE=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_44-34fe680.tar.gz/Translate-REL1_44-34fe680.tar.gz";
    hash = "sha256-BZOzoiy1tNYW7exCF0/7x6hvXuLc9KfaXyEQkRDyBk4=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_44-b6b3e9f.tar.gz/UniversalLanguageSelector-REL1_44-b6b3e9f.tar.gz";
    hash = "sha256-qFC7aTc9pywqQTb3ynM6DqnrCImMTbs1h20vE/7oXGw=";
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
