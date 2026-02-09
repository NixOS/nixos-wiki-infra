{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_45-75f7653.tar.gz/MobileFrontend-REL1_45-75f7653.tar.gz";
    hash = "sha256-JXAneqbwn/p4siOxabv5JdwYWVmYhkJlTGL7dT4EGAE=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_45-7b14621.tar.gz/DarkMode-REL1_45-7b14621.tar.gz";
    hash = "sha256-lJM3s0pI80Uam8jXuDVzdXsBYpYi1QhN6tolTjO87TQ=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_45-6686fc0.tar.gz/QuickInstantCommons-REL1_45-6686fc0.tar.gz";
    hash = "sha256-z3vHbtfb/6EWvsEM2+wJ+OJE64M3iG7P3IhK+T/txeQ=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_45-2f918a5.tar.gz/Translate-REL1_45-2f918a5.tar.gz";
    hash = "sha256-dkp6gTpM1uUW9gA454wyBqYnFSxARyHROw7yxDI67T4=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_45-5b42101.tar.gz/UniversalLanguageSelector-REL1_45-5b42101.tar.gz";
    hash = "sha256-zKQCv2X5KjaVncaZTaEVjFX/AeZ0Fp3Yjt8glhkBl+w=";
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
