{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-b2c9055.tar.gz/MobileFrontend-REL1_43-b2c9055.tar.gz";
    hash = "sha256-xiMg4T1hZLOLh3gxEhilw2XOVYer8RGGUyYZlvwYTt0=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-86613f8.tar.gz/Translate-REL1_43-86613f8.tar.gz";
    hash = "sha256-S7p6Lr4cmDpsmFTNsqxJL1Te5Jhv5byrpaVlDPZEZG8=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-4ad159f.tar.gz/UniversalLanguageSelector-REL1_43-4ad159f.tar.gz";
    hash = "sha256-COB+N6q7lIYM7Vc334W3N8knrnhSlEpLIA/QM6Y6a6o=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_43-50e2aef.tar.gz/Description2-REL1_43-50e2aef.tar.gz";
    hash = "sha256-ciUEUcg4tsgpvohuLYztFaGNBowR7p1dIKnNp4ooKtA=";
  };
  "Mermaid" = fetchzip {
    url = "https://github.com/SemanticMediaWiki/Mermaid/archive/refs/tags/3.1.0.zip";
    hash = "sha256-tLOdAsXsaP/URvKcl5QWQiyhMy70qn8Fi8g3+ecNOWQ=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/archive/refs/tags/v0.3.2.zip";
    hash = "sha256-0jMxLX7r4w44WMvtDt421vX+s622+j7WjbK6ClS/FKk=";
  };
}
