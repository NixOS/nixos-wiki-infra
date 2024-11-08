{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-16d8587.tar.gz/MobileFrontend-REL1_42-16d8587.tar.gz";
    hash = "sha256-eY42heNdAVoXgPUHbMwY2V69PDr4KhDSn9gsrJeg9i0=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-b57ac94.tar.gz/Translate-REL1_42-b57ac94.tar.gz";
    hash = "sha256-U2w65Y57CjSJjG7Qdz4RhQeVo81SVRvNOG29krvobvQ=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-3beec42.tar.gz/UniversalLanguageSelector-REL1_42-3beec42.tar.gz";
    hash = "sha256-ENKj4s6KQ9hV4wHVDHZuC8OEtHHQ2xPLTL9CqqMM0HU=";
  };
}
