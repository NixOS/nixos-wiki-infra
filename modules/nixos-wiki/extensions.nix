{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_44-b7eaef9.tar.gz/MobileFrontend-REL1_44-b7eaef9.tar.gz";
    hash = "sha256-T45uEDirjkcCUF1HmdVSN5uvtDRP/utdwpAGWwuvdaA=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_44-3db4d9b.tar.gz/Translate-REL1_44-3db4d9b.tar.gz";
    hash = "sha256-Y7hdJbn9BJZOPdBr1OTVvWo9Lfg3+qm8l+q8RsWmnFw=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_44-f2c8d76.tar.gz/UniversalLanguageSelector-REL1_44-f2c8d76.tar.gz";
    hash = "sha256-0daT/WPaIiMSkdtOLw0mEzKcwewGSWZbX+pBLNQIIVk=";
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
