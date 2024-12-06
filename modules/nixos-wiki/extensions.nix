{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-f8ea869.tar.gz/MobileFrontend-REL1_42-f8ea869.tar.gz";
    hash = "sha256-aUVt/elcE4F+zMqaRM6SuKdwzhxgtvU305xZcL6TOmA=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-5cd4bb3.tar.gz/Translate-REL1_42-5cd4bb3.tar.gz";
    hash = "sha256-W4OLDRT+QXPwBIj5o3Lrq8+k2sFeTJ7JgOt8rgLYq3o=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-8a8a323.tar.gz/UniversalLanguageSelector-REL1_42-8a8a323.tar.gz";
    hash = "sha256-zvLO0woDgTjU58iKy7EsuJtuypfFqV+gDKgXvhOmO0g=";
  };
}
