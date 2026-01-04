{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_45-2bccb7e.tar.gz/MobileFrontend-REL1_45-2bccb7e.tar.gz";
    hash = "sha256-plQ5hgFO3k/Pz8TAigx3vT3aW+ZtyvM6Vv1lCUbfVCE=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_45-769cde0.tar.gz/DarkMode-REL1_45-769cde0.tar.gz";
    hash = "sha256-HjkSImPRTXzwBu9H1yzfTa/vKnH2dPYqJn32X0DuuA8=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_45-0c61295.tar.gz/QuickInstantCommons-REL1_45-0c61295.tar.gz";
    hash = "sha256-PyFEfqQnGZyj8oDGOuN/d7XV4cpn8xfJxo9gJqKuBuc=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_45-a7ac8f1.tar.gz/Translate-REL1_45-a7ac8f1.tar.gz";
    hash = "sha256-c42jubSAm7vA+6lsOLIg4DE4WMiCSlxck6nmfUU1Goo=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_45-99fe9bc.tar.gz/UniversalLanguageSelector-REL1_45-99fe9bc.tar.gz";
    hash = "sha256-PD1QSjypLp/qVC9PNmVvc3pccYU1VbXmEek7B7ub9l0=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_45-2a547bf.tar.gz/Description2-REL1_45-2a547bf.tar.gz";
    hash = "sha256-6tUD/vW131vgKOIcUwJAZUpgd9VWspbqIisaqNwuaJg=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.3/AuthManagerOAuth.zip";
    hash = "sha256-xReQzh/ZcQsOD/qb3iqbgSeNOh+7pE6d7h6Sc/aHyTw=";
  };
}
