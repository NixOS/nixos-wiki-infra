{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_44-afd398d.tar.gz/MobileFrontend-REL1_44-afd398d.tar.gz";
    hash = "sha256-XrtL9qESUFYRulWDQOhB4O0mHqudoWJNHsMSDUAMPSg=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_44-b8394f0.tar.gz/DarkMode-REL1_44-b8394f0.tar.gz";
    hash = "sha256-u9b3XyXMDRCb9NaslmPIRjY5pA8WW+GB+GSvZUvztUQ=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_44-004f271.tar.gz/QuickInstantCommons-REL1_44-004f271.tar.gz";
    hash = "sha256-KZlHoOnr8TWZ1yIujq+DT2qiajB5JCseS9mBY2jDSvM=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_44-bd988d6.tar.gz/Translate-REL1_44-bd988d6.tar.gz";
    hash = "sha256-o2BfJQk6QXsQEHNKD0rWQ3NAmJjR8kvU6wM81Jgg9Ps=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_44-91722c1.tar.gz/UniversalLanguageSelector-REL1_44-91722c1.tar.gz";
    hash = "sha256-vl+df6xnrRXTQUD0xSXkMTdXBQZMsaXSvyLLXHUK9hE=";
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
