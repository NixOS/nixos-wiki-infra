{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-3fe3a69.tar.gz/MobileFrontend-REL1_42-3fe3a69.tar.gz";
    hash = "sha256-/OO2YtqstVuisAQEovw/0N5qTKRBfGyUiXuscXVMCxw=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-1474d2f.tar.gz/Translate-REL1_42-1474d2f.tar.gz";
    hash = "sha256-KrwgenIfNOp3JWAQ8F9OD11156f8H2LCifnuIKmUAZo=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-3581bbf.tar.gz/UniversalLanguageSelector-REL1_42-3581bbf.tar.gz";
    hash = "sha256-JhDso6JRvnvU1p/DEqVNYC1mEQ6Ozr6OLRZqlA+VBB0=";
  };
}
