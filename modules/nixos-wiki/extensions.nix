{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-4e374e8.tar.gz/MobileFrontend-REL1_42-4e374e8.tar.gz";
    hash = "sha256-X1Fmc2P3N+Z2Hp+i+xQS0RuWArAxWLAT03mX107GXwI=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-21eb1c4.tar.gz/Translate-REL1_42-21eb1c4.tar.gz";
    hash = "sha256-X9DovT6TKOl07og9v5RjFdruKhgBNuhhcm2QGn9D1u4=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-48bf997.tar.gz/UniversalLanguageSelector-REL1_42-48bf997.tar.gz";
    hash = "sha256-eq1dxZkkcvKb0zRdc4D6lK93kBFY8AjSzNrjp+bTALk=";
  };
}
