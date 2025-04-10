{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-e4f29f0.tar.gz/MobileFrontend-REL1_43-e4f29f0.tar.gz";
    hash = "sha256-7UJupnJYBydRbFTV9au3MoXAwW4zaaN1JZ7kL+a57RY=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-3ebda29.tar.gz/Translate-REL1_43-3ebda29.tar.gz";
    hash = "sha256-wtBVVu6eAeXWgzGgV/0HJQmoRqRUmyr1rUV0VmZDOIA=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-0114937.tar.gz/UniversalLanguageSelector-REL1_43-0114937.tar.gz";
    hash = "sha256-jPhRK3lu9e3M2oBiLAcRwTqKvZjk/6cblbqo91ZnrlM=";
  };
}
