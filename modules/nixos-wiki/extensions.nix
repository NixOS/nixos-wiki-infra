{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-64d7c57.tar.gz/MobileFrontend-REL1_42-64d7c57.tar.gz";
    hash = "sha256-gMXoJvrNrF6X+Hu93KRaT+knHQbLRGlibH6Gt/SqhOk=";
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
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_42-8e54a38.tar.gz/Translate-REL1_42-8e54a38.tar.gz";
    hash = "sha256-bAbtJy7buxJrAt0MdWFB340fYDqaggIADb1t7gTxPeM=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_42-5b9eb56.tar.gz/UniversalLanguageSelector-REL1_42-5b9eb56.tar.gz";
    hash = "sha256-ztiid785tGPQWgHcpUdciyXa1jGitx+xyYH2f5HwaMU=";
  };
}
