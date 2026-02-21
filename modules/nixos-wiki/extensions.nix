{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_45-35c9972.tar.gz/MobileFrontend-REL1_45-35c9972.tar.gz";
    hash = "sha256-DeDk65vNS+tAKHlztpVLrANrcG/k8g/wSYrHjjbjcO8=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_45-4bb5abb.tar.gz/DarkMode-REL1_45-4bb5abb.tar.gz";
    hash = "sha256-XLs+pH9UGwq3OFPEGBwNbN+dlnKDI31GEfP6X1EL6iU=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_45-6686fc0.tar.gz/QuickInstantCommons-REL1_45-6686fc0.tar.gz";
    hash = "sha256-z3vHbtfb/6EWvsEM2+wJ+OJE64M3iG7P3IhK+T/txeQ=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_45-48b2205.tar.gz/Translate-REL1_45-48b2205.tar.gz";
    hash = "sha256-UCR4Do+27SgCMDl7477k6IrevR2UrhsPXLk4PFh0mDc=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_45-89e9a40.tar.gz/UniversalLanguageSelector-REL1_45-89e9a40.tar.gz";
    hash = "sha256-9ciwBAjhcIEJLcckA6cpcdKViCWwLGUFFxaiimGqa80=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_45-a7102ff.tar.gz/Description2-REL1_45-a7102ff.tar.gz";
    hash = "sha256-OiczzmzeqM4mCSreQ2AEri8Z6S3VsW7PEXGZXu/O0BM=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.3/AuthManagerOAuth.zip";
    hash = "sha256-xReQzh/ZcQsOD/qb3iqbgSeNOh+7pE6d7h6Sc/aHyTw=";
  };
}
