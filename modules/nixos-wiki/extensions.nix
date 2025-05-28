{ fetchzip }:
{
  "MobileFrontend" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_43-4688c87.tar.gz/MobileFrontend-REL1_43-4688c87.tar.gz";
    hash = "sha256-Hgqmwy0W5BLL+OhI2lw+T1kothP5RwS+Q3TvW04Co+M=";
  };
  "DarkMode" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_43-dc25af0.tar.gz/DarkMode-REL1_43-dc25af0.tar.gz";
    hash = "sha256-Ikmz2YlN5D0XelqUYGbabZhiu731SYb+AuifYZHyGwE=";
  };
  "QuickInstantCommons" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_43-11bfc97.tar.gz/QuickInstantCommons-REL1_43-11bfc97.tar.gz";
    hash = "sha256-u7fxFmjt8FWp3kTHZvHIy7CZ+1R8Dl/YSBqSwxuxJJU=";
  };
  "Translate" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/Translate-REL1_43-237e3ea.tar.gz/Translate-REL1_43-237e3ea.tar.gz";
    hash = "sha256-7hA5q5M/YhSSo6A6O4Gd1zZN+UfRm8kQ+SR6BvSoDVs=";
  };
  "UniversalLanguageSelector" = fetchzip {
    url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/UniversalLanguageSelector-REL1_43-91516f2.tar.gz/UniversalLanguageSelector-REL1_43-91516f2.tar.gz";
    hash = "sha256-DVricrriXsWWuV1+/VzJ9RzqGmkgFW0havA5bjBSMzg=";
  };
}
