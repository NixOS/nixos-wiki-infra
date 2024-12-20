{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-a8aeecc.tar.gz/MobileFrontend-REL1_42-a8aeecc.tar.gz";
    hash = "sha256-QTeQu5hQG9TLr5Fee3g78Hxk3odtKd6NMOa2KF+e9nk=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-b432171.tar.gz/Translate-REL1_42-b432171.tar.gz";
    hash = "sha256-9kpvH1FmEDiqnWFpNGENxxI8rxECF7yQrtyfwVlblHw=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-018f27f.tar.gz/UniversalLanguageSelector-REL1_42-018f27f.tar.gz";
    hash = "sha256-hw1kcWVkxcpoT9950pYmoU3TTqKSah40qh4z/BRPM3A=";
  };
}
