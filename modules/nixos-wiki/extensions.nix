{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_45-ebb53d7.tar.gz/MobileFrontend-REL1_45-ebb53d7.tar.gz";
    hash = "sha256-DrtXESvTyvi73ocBMpObvw2zivZn+vTOnHTbFy7COuU=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_45-c3fea63.tar.gz/DarkMode-REL1_45-c3fea63.tar.gz";
    hash = "sha256-GWzDffvnepoE2oTog8EPmQYIO+y+Wjye070/Pb7WizM=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_45-0c61295.tar.gz/QuickInstantCommons-REL1_45-0c61295.tar.gz";
    hash = "sha256-PyFEfqQnGZyj8oDGOuN/d7XV4cpn8xfJxo9gJqKuBuc=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_45-25e90cd.tar.gz/Translate-REL1_45-25e90cd.tar.gz";
    hash = "sha256-RnQKBE+0lUXzDblJa1vTLafasWm7vqvxMR6keDxIkGQ=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_45-5dc09b3.tar.gz/UniversalLanguageSelector-REL1_45-5dc09b3.tar.gz";
    hash = "sha256-9EkLa6WYXoVFKf4jtPpmfyNmi4sYF460wyx3DC6lLV0=";
  };
  "Description2" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Description2-REL1_45-cc1d802.tar.gz/Description2-REL1_45-cc1d802.tar.gz";
    hash = "sha256-55nz/PwfJzeRDH7LtHpjNTiVxG4LJXqf3Yz5XN4u4o0=";
  };
  "AuthManagerOAuth" = fetchzip {
    url = "https://github.com/mohe2015/AuthManagerOAuth/releases/download/v0.3.3/AuthManagerOAuth.zip";
    hash = "sha256-xReQzh/ZcQsOD/qb3iqbgSeNOh+7pE6d7h6Sc/aHyTw=";
  };
}
