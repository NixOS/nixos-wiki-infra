{ fetchzip }: {
  "MobileFrontend" = fetchzip { url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_41-26b5543.tar.gz/MobileFrontend-REL1_41-26b5543.tar.gz"; sha256 = "0cjpsyn665p3d4lyhf5mhg7p8vgcyf3jmp9a0disgh7wczj620x8"; };
  "DarkMode" = fetchzip { url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_41-ed0fbad.tar.gz/DarkMode-REL1_41-ed0fbad.tar.gz"; sha256 = "1m403p17nbpcdgkj7691qpwj8g0146dmink13ay01395hzc9f3js"; };
  "QuickInstantCommons" = fetchzip { url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_41-2a29b3e.tar.gz/QuickInstantCommons-REL1_41-2a29b3e.tar.gz"; sha256 = "1maqrx9k2bikin6fqn920v9l5nxaijpk14m0g2wpipryxx727vni"; };
}
