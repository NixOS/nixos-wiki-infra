{ fetchzip }: {
  "MobileFrontend" = fetchzip { url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/MobileFrontend-REL1_42-762b528.tar.gz/MobileFrontend-REL1_42-762b528.tar.gz"; sha256 = "153psy35c28sz0nvhhxk0plw6x76gjn43jqv31753jji0xalnjqm"; };
  "DarkMode" = fetchzip { url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/DarkMode-REL1_42-01e7144.tar.gz/DarkMode-REL1_42-01e7144.tar.gz"; sha256 = "1c9p52mylxbnf15n9xnhvjsx766bz01b176y4kzrzgcnivf1ssrb"; };
  "QuickInstantCommons" = fetchzip { url = "https://github.com/NixOS/nixos-wiki-infra/releases/download/QuickInstantCommons-REL1_42-3e6a069.tar.gz/QuickInstantCommons-REL1_42-3e6a069.tar.gz"; sha256 = "0vc6drd3j32wc4z4yc5g5dhh8x1904jsws31h4x8x47l3a78vfak"; };
}
