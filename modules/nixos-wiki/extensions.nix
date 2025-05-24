{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-81707e5.tar.gz/MobileFrontend-REL1_43-81707e5.tar.gz";
    hash = "sha256-G86iox7wMgDLooQvEyPDlYtImHuWmfW3WVyq2p/alZo=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_43-0105360.tar.gz/DarkMode-REL1_43-0105360.tar.gz";
    hash = "sha256-Nm0OKuF39J8xM7WTFfW1Jgy4f+rmGtmDDVfIBLjmsy0=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_43-d780214.tar.gz/QuickInstantCommons-REL1_43-d780214.tar.gz";
    hash = "sha256-kVVS7Q4xbbLZGFpedzVhe/xkznblQ/Jctw/1ornctiU=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-5586bd6.tar.gz/Translate-REL1_43-5586bd6.tar.gz";
    hash = "sha256-QjtItihudMggIzq0QwISW06Cujhm9+pSHaIoRMQAEls=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-87e6d35.tar.gz/UniversalLanguageSelector-REL1_43-87e6d35.tar.gz";
    hash = "sha256-Hsp67JDft2frRa4XVuHg3N9rySnAgS8xUpp8SnGdIhA=";
  };
}
