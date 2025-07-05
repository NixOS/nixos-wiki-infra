{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-0582341.tar.gz/MobileFrontend-REL1_43-0582341.tar.gz";
    hash = "sha256-xwvEsEOXMCiem922ydv/wCUx6HjoNtyP4iZMpLCM4Cg=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-295c247.tar.gz/Translate-REL1_43-295c247.tar.gz";
    hash = "sha256-wSYRDyDoG6Cm7XmmihAC7tsbuAfPF3x+zPrDGadSY8I=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-cc4919a.tar.gz/UniversalLanguageSelector-REL1_43-cc4919a.tar.gz";
    hash = "sha256-6+kBXNmsceZWWdpxNHcYi4kmLk4F7gj5q1HFyv7Lzg8=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_43-0eb3253.tar.gz/Description2-REL1_43-0eb3253.tar.gz";
    hash = "sha256-zhbHSSmGZt9jvGuB0mk49tiotmJulOUp+mt5drnu40w=";
  };
  "Mermaid" = fetchzip {
    url = "https://github.com/SemanticMediaWiki/Mermaid/archive/refs/tags/5.0.2.zip";
    hash = "sha256-takDzg3IoNCvLegQPHbIJbvR1dVMW5wO3yM8qC1jtcY=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.3/AuthManagerOAuth.zip";
    hash = "sha256-xReQzh/ZcQsOD/qb3iqbgSeNOh+7pE6d7h6Sc/aHyTw=";
  };
}
