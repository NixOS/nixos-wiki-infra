{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-7fc2f8e.tar.gz/MobileFrontend-REL1_43-7fc2f8e.tar.gz";
    hash = "sha256-WB3PSWTa7knvT129ikaH8kINQ9rB2MsMrDssbqomCqA=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_43-c1b6238.tar.gz/DarkMode-REL1_43-c1b6238.tar.gz";
    hash = "sha256-QKPrSHb7JA3MDdCQX13bccDd0mxCJWCS8a2XGolKOys=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_43-3330ce1.tar.gz/QuickInstantCommons-REL1_43-3330ce1.tar.gz";
    hash = "sha256-JVNHE4hQD+gk/ber728QJck2OS76jaHEyVWr45+P/HI=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-47ce718.tar.gz/Translate-REL1_43-47ce718.tar.gz";
    hash = "sha256-GYSxUOFSsVUJDYRahQCOD8k4g9Fp2MGurdtlvs/x5RQ=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-ffadcfa.tar.gz/UniversalLanguageSelector-REL1_43-ffadcfa.tar.gz";
    hash = "sha256-41FZ/kBDQT6J1NuLwJsG3NpbVd6q1Ft0Yc4ZkPBM1VU=";
  };
}
