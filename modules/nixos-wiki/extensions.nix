{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_45-a83bec1.tar.gz/MobileFrontend-REL1_45-a83bec1.tar.gz";
    hash = "sha256-sjl0dVSshKHQFz/+RdxM7C0vjW40N8vn//pQqurBXY4=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_45-0299331.tar.gz/DarkMode-REL1_45-0299331.tar.gz";
    hash = "sha256-ImiejLe1Yrz14t8EeE/qoUCLUlBmJNA2NiNK+Opo7cs=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_45-9b08f21.tar.gz/QuickInstantCommons-REL1_45-9b08f21.tar.gz";
    hash = "sha256-cu6PJaZjjF+FWSrSsl8YpFTv4Bo+d6/ewikEkJMEom4=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_45-b9e34d8.tar.gz/Translate-REL1_45-b9e34d8.tar.gz";
    hash = "sha256-Fkk0iiEupZZnv6jQv6EWGjpn9WOi+KsJ3+W3GeAoSwI=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_45-71e73bb.tar.gz/UniversalLanguageSelector-REL1_45-71e73bb.tar.gz";
    hash = "sha256-hbu4CAcnFRWPBIOqj/nexGe6au9m1UEWIftYesRX1xs=";
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
