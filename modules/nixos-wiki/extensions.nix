{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_45-91aac0e.tar.gz/MobileFrontend-REL1_45-91aac0e.tar.gz";
    hash = "sha256-fOLNBjC1ti403cdoOGcIH97QVRufBvNT94cJFpePWlo=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_45-0299331.tar.gz/DarkMode-REL1_45-0299331.tar.gz";
    hash = "sha256-ImiejLe1Yrz14t8EeE/qoUCLUlBmJNA2NiNK+Opo7cs=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_45-6686fc0.tar.gz/QuickInstantCommons-REL1_45-6686fc0.tar.gz";
    hash = "sha256-z3vHbtfb/6EWvsEM2+wJ+OJE64M3iG7P3IhK+T/txeQ=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_45-71eca50.tar.gz/Translate-REL1_45-71eca50.tar.gz";
    hash = "sha256-is4D48BYIHnJTG0TIljgJ+TkONNY3ntmI8rK2w6MO3I=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_45-b941709.tar.gz/UniversalLanguageSelector-REL1_45-b941709.tar.gz";
    hash = "sha256-XicypO36ItZdTnx7cVsE6CD0+JQDKyTx3odBrVU1nBw=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_45-726d7ae.tar.gz/Description2-REL1_45-726d7ae.tar.gz";
    hash = "sha256-c2SLRgdviWaTEPCTdu30zCYvNMXN67bQLOQaL7fVgW0=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.3/AuthManagerOAuth.zip";
    hash = "sha256-xReQzh/ZcQsOD/qb3iqbgSeNOh+7pE6d7h6Sc/aHyTw=";
  };
}
