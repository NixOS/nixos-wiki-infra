{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_44-086a79a.tar.gz/MobileFrontend-REL1_44-086a79a.tar.gz";
    hash = "sha256-SFeEYqBPGOZ+I1h3qGdMQWkntI2TX1DJATsvJXJ63yE=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_44-1561924.tar.gz/DarkMode-REL1_44-1561924.tar.gz";
    hash = "sha256-/x+H3SlomcIGjlZ7QiuVaCHxOaeHc+mNpWm9iJfyaFw=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_44-6ee3f47.tar.gz/QuickInstantCommons-REL1_44-6ee3f47.tar.gz";
    hash = "sha256-wqa4VbjXnF59e/DRRkUX+nd45l+PLxTCMQXv5vBZ0BM=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_44-266563a.tar.gz/Translate-REL1_44-266563a.tar.gz";
    hash = "sha256-V5ukpD7dXBF5GvUAjJOZ2k4fC+jqOLg8LCTyGfJmsag=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_44-f03d369.tar.gz/UniversalLanguageSelector-REL1_44-f03d369.tar.gz";
    hash = "sha256-pi+VQYpTvRIvYucB0Etlo7IsjeU+n2HpH5ZShgGFNuo=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_44-defa8c4.tar.gz/Description2-REL1_44-defa8c4.tar.gz";
    hash = "sha256-PYLQyH1+vZVR0brbBgHhYkAVR2H3jK1R4CuEAL3cJdI=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.3/AuthManagerOAuth.zip";
    hash = "sha256-xReQzh/ZcQsOD/qb3iqbgSeNOh+7pE6d7h6Sc/aHyTw=";
  };
}
