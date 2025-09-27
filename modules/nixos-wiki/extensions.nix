{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_44-c75c95d.tar.gz/MobileFrontend-REL1_44-c75c95d.tar.gz";
    hash = "sha256-YcRp3ApyB4lYYuGE9MJsf51GCfMC5EX2GMYZrc8kAck=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_44-bc50f3a.tar.gz/Translate-REL1_44-bc50f3a.tar.gz";
    hash = "sha256-7/CTJ/6eSHO40mEHtRuLcH0qVLdZU8kIRSwf4D1WcN8=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_44-44fd925.tar.gz/UniversalLanguageSelector-REL1_44-44fd925.tar.gz";
    hash = "sha256-cvD/Nlq+7w9vKCQrfq7Dq6OlUHD9lOkTFxO8Ea9CA24=";
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
