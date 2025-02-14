{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-d695f10.tar.gz/MobileFrontend-REL1_42-d695f10.tar.gz";
    hash = "sha256-NoB2yEk48OushUiHHO6NAFtTn7Zmf9Sh0QY23u2dRxY=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-3806370.tar.gz/Translate-REL1_42-3806370.tar.gz";
    hash = "sha256-nAzG+RnPy8M1f3YmpbGWGDEZrN1npXKuew+rLQym7dE=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-48e6777.tar.gz/UniversalLanguageSelector-REL1_42-48e6777.tar.gz";
    hash = "sha256-fCum39aOAHps5DsDyzNpRU0XpR6r+VTMwhkNTXP94LA=";
  };
}
