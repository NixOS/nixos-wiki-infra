{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-6c0b81d.tar.gz/MobileFrontend-REL1_42-6c0b81d.tar.gz";
    hash = "sha256-jybpz8MiB94vmqWzxvtjsHR3tbOeygfKWAOb3KjyK3w=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-6c7e5f3.tar.gz/Translate-REL1_42-6c7e5f3.tar.gz";
    hash = "sha256-DjJHLFLCrNVcfHZ6RFDIFVhDl2Sr4xUgsqjd++xnlkI=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-03f4a6c.tar.gz/UniversalLanguageSelector-REL1_42-03f4a6c.tar.gz";
    hash = "sha256-oD2dAvJXlVfvWRaTKI9xq13ftb5AJimgjESO7wITgIw=";
  };
}
