{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-4ead8e9.tar.gz/MobileFrontend-REL1_43-4ead8e9.tar.gz";
    hash = "sha256-UdBssPfSRB87AGGJ6HakMq7nAPP0aoVsUpsz2x1I0uU=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-7e7607a.tar.gz/Translate-REL1_43-7e7607a.tar.gz";
    hash = "sha256-UacrgbUDdrW80HdklZmEmL3xqtGyrRSnzVYkh+frB9E=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-5eb5ecd.tar.gz/UniversalLanguageSelector-REL1_43-5eb5ecd.tar.gz";
    hash = "sha256-zlTPHiSI71cb/WjcjjEtXfkvuDWw+NWm4oQBkWToX90=";
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
