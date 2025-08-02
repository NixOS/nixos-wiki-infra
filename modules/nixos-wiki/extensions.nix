{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_44-52bd895.tar.gz/MobileFrontend-REL1_44-52bd895.tar.gz";
    hash = "sha256-hB9spca8Vp9z+aYX6rmELaCw4pvwhxBhj0T+eiAh9xQ=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_44-4b937c9.tar.gz/DarkMode-REL1_44-4b937c9.tar.gz";
    hash = "sha256-y6cpbJDfBKLMWnT/n2bCdJMch+qaGIqc30ZgI/j69Do=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_44-6ee3f47.tar.gz/QuickInstantCommons-REL1_44-6ee3f47.tar.gz";
    hash = "sha256-wqa4VbjXnF59e/DRRkUX+nd45l+PLxTCMQXv5vBZ0BM=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_44-d84f8b2.tar.gz/Translate-REL1_44-d84f8b2.tar.gz";
    hash = "sha256-RNahQ8VnUjp+BNlLHT7bOsol9crfp7Wo79oMoOPjcfM=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_44-7408158.tar.gz/UniversalLanguageSelector-REL1_44-7408158.tar.gz";
    hash = "sha256-XP8aQGGiZvSB5qH50SaBWeEaN97L8QPEYPvc7iS1NlI=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_44-defa8c4.tar.gz/Description2-REL1_44-defa8c4.tar.gz";
    hash = "sha256-PYLQyH1+vZVR0brbBgHhYkAVR2H3jK1R4CuEAL3cJdI=";
  };
  "Mermaid" = fetchzip {
    url = "https://github.com/SemanticMediaWiki/Mermaid/archive/refs/tags/6.0.1.zip";
    hash = "sha256-ioeoVh0jDrhrxBfWrY2PfLIBxjgb/5/UlNx3RnHv/5Q=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.3/AuthManagerOAuth.zip";
    hash = "sha256-xReQzh/ZcQsOD/qb3iqbgSeNOh+7pE6d7h6Sc/aHyTw=";
  };
}
