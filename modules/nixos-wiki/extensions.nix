{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-a9969ab.tar.gz/MobileFrontend-REL1_42-a9969ab.tar.gz";
    hash = "sha256-nK+zji/z2ak3VpZ9izzBbUyToZ9+PQnFU7AhObtt5ic=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-d0d0b5a.tar.gz/Translate-REL1_42-d0d0b5a.tar.gz";
    hash = "sha256-t06HmOqSQ4jnZAkavI59BBqczw3+WpEWZdA1GGW/oJ8=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-17f1d7e.tar.gz/UniversalLanguageSelector-REL1_42-17f1d7e.tar.gz";
    hash = "sha256-x7kKGAdtqauQFXzCAUYz2aERE86MTbWRs08xWSBTnvQ=";
  };
}
