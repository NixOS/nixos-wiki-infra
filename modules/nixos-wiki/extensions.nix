{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_45-9a3d96c.tar.gz/MobileFrontend-REL1_45-9a3d96c.tar.gz";
    hash = "sha256-IKNBda/6bUl27w26Mm/Z8O7wLYJqVtMYt0GDRe5RifA=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_45-5ab21be.tar.gz/Translate-REL1_45-5ab21be.tar.gz";
    hash = "sha256-hj6n12aK2jizw+GMa/jD+usK05A/lrdx7xk6OPDQxJU=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_45-77e7796.tar.gz/UniversalLanguageSelector-REL1_45-77e7796.tar.gz";
    hash = "sha256-/WqogkltZJ28RJkIDrDa+Qi7loP/zMTC7ah7VW/KT2Q=";
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
