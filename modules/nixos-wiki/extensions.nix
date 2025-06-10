{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-520eb1c.tar.gz/MobileFrontend-REL1_43-520eb1c.tar.gz";
    hash = "sha256-Xd91d/JdZAZkUvzOq85tpPm2Um+JY08WQQPDjLiqhvE=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_43-dc25af0.tar.gz/DarkMode-REL1_43-dc25af0.tar.gz";
    hash = "sha256-Ikmz2YlN5D0XelqUYGbabZhiu731SYb+AuifYZHyGwE=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_43-c0cc0c9.tar.gz/QuickInstantCommons-REL1_43-c0cc0c9.tar.gz";
    hash = "sha256-RX5VoB69n1EAy7xxgDlnfBybZrm4w3ygI+sktIUb4OY=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-8b31384.tar.gz/Translate-REL1_43-8b31384.tar.gz";
    hash = "sha256-pETZ0EncwqBDEYzFkFoBo8sUl6koQRZB2NE4ZADAgZ0=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-7a86dab.tar.gz/UniversalLanguageSelector-REL1_43-7a86dab.tar.gz";
    hash = "sha256-KMKEZAMqpBr4SzMud51vxEscA+Vpq1sh1CB3DzpWPwk=";
  };
}
