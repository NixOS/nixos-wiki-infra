{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-cfd30fc.tar.gz/MobileFrontend-REL1_42-cfd30fc.tar.gz";
    hash = "sha256-2Sp4C3KMMB7Sa3Ndi0BaAYw8qhBc7qpacQGtvTnshAs=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-8334e21.tar.gz/Translate-REL1_42-8334e21.tar.gz";
    hash = "sha256-0J7OwpcmpMNxt4jylhZAXoiqJTIsxJDSFxOKSFDUnPU=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-62296b3.tar.gz/UniversalLanguageSelector-REL1_42-62296b3.tar.gz";
    hash = "sha256-RKH/3MFGupZ1M4wGfq7W+Xdn6p3hwXr2/cJDPnAQxxo=";
  };
}
