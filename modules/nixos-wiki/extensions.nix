{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-b34dfe0.tar.gz/MobileFrontend-REL1_42-b34dfe0.tar.gz";
    hash = "sha256-c5cevmIB41BRSLx+h4emNtqmUTUjmzuT9L7EUzfhOKE=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_42-66aad97.tar.gz/DarkMode-REL1_42-66aad97.tar.gz";
    hash = "sha256-xt7+yiD2oDsK0q7tsqAtYdiKcLqWr8DiWl+zAmoqQpg=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_42-3e6a069.tar.gz/QuickInstantCommons-REL1_42-3e6a069.tar.gz";
    hash = "sha256-U7mNjhr0kI46gWForiUBKXQEYSuvME8+YVwMOVpuhm0=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-81dc267.tar.gz/Translate-REL1_42-81dc267.tar.gz";
    hash = "sha256-n21p7a9pL36Z6WxvVxx1yS8fOGpsst63SosJtCNiPXY=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-ab4b3c8.tar.gz/UniversalLanguageSelector-REL1_42-ab4b3c8.tar.gz";
    hash = "sha256-oQ9SnIx9wYkAS2gHDAQOQmdWPGwv2+Sk5ZNU27iiR0o=";
  };
}
