{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_45-654d847.tar.gz/MobileFrontend-REL1_45-654d847.tar.gz";
    hash = "sha256-gQ8HtOYs/damKkyOPPJmiLHYMbtuUYQ/VJrpcV4A+pg=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_45-7b14621.tar.gz/DarkMode-REL1_45-7b14621.tar.gz";
    hash = "sha256-lJM3s0pI80Uam8jXuDVzdXsBYpYi1QhN6tolTjO87TQ=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_45-6c569fb.tar.gz/QuickInstantCommons-REL1_45-6c569fb.tar.gz";
    hash = "sha256-KCS6gwSamz/OdXKm4PyFNnodga8xvd2aZK8AJK4Mzis=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_45-965a16d.tar.gz/Translate-REL1_45-965a16d.tar.gz";
    hash = "sha256-CDP8ZhxuuaeGgDUiHRDGZrWxXlOX1/q39JYQE/S4Xcg=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_45-a1adf51.tar.gz/UniversalLanguageSelector-REL1_45-a1adf51.tar.gz";
    hash = "sha256-AhhNImjUzynERICvqpj9vHxrcK4rrVYMyCOe1u2QvWI=";
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
