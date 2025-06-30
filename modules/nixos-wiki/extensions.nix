{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-7495c73.tar.gz/MobileFrontend-REL1_43-7495c73.tar.gz";
    hash = "sha256-nzc/i28kGgTFU9IlskJhCoXvFO0jwYr2nzOrOLVcFnE=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_43-e04ad8e.tar.gz/DarkMode-REL1_43-e04ad8e.tar.gz";
    hash = "sha256-ARUhmQ2EcaQ2a0qLh4dWx2EcYooCmmPVwS7DcbR+iKI=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_43-c0cc0c9.tar.gz/QuickInstantCommons-REL1_43-c0cc0c9.tar.gz";
    hash = "sha256-RX5VoB69n1EAy7xxgDlnfBybZrm4w3ygI+sktIUb4OY=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-3a008de.tar.gz/Translate-REL1_43-3a008de.tar.gz";
    hash = "sha256-Ga0md4pVC2JmMKJZWUf+GWLgM40isMDaON6+mD9uZsM=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-fcc1a1b.tar.gz/UniversalLanguageSelector-REL1_43-fcc1a1b.tar.gz";
    hash = "sha256-hYhGwNNFZP3RWlzAymokRA73Xe7O++3dmmJSUqAhJsc=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_43-0eb3253.tar.gz/Description2-REL1_43-0eb3253.tar.gz";
    hash = "sha256-zhbHSSmGZt9jvGuB0mk49tiotmJulOUp+mt5drnu40w=";
  };
  "Mermaid" = fetchzip {
    url = "https://github.com/SemanticMediaWiki/Mermaid/archive/refs/tags/3.1.0.zip";
    hash = "sha256-tLOdAsXsaP/URvKcl5QWQiyhMy70qn8Fi8g3+ecNOWQ=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.3/AuthManagerOAuth.zip";
    hash = "sha256-xReQzh/ZcQsOD/qb3iqbgSeNOh+7pE6d7h6Sc/aHyTw=";
  };
}
