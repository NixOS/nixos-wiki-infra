{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-881f113.tar.gz/MobileFrontend-REL1_42-881f113.tar.gz";
    hash = "sha256-5mcB8hzAoDa73uIt/tD/QguGwZrAMT3/6dsolvZXlqQ=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-59e6783.tar.gz/Translate-REL1_42-59e6783.tar.gz";
    hash = "sha256-hCsa0ck3R1qyRYS1Oeq8LgFV8CH5CSN3qUpJF7I1akY=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-081f5b1.tar.gz/UniversalLanguageSelector-REL1_42-081f5b1.tar.gz";
    hash = "sha256-dzhdHg904Z0Sik00MyqA8R3GeyKZEBNZnWass3ViSYY=";
  };
}
