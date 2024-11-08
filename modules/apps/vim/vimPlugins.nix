with import <nixpkgs> {};

let inherit (vimUtils) buildVimPluginFrom2Nix; in {
  "jedi-vim" = buildVimPluginFrom2Nix {
    name = "jedi-vim";
    src = fetchgit {
      # github repo
      url = "https://github.com/davidhalter/jedi-vim";
      # rev/commit hash
      rev = "b82da7d2b5efa28449f1a46e906dee439f68240c";
      # sha256 hash
      sha256 = "DuQ9PtYd5t3BQOhPO9rkvs0Twe1UIXl+aR2hSxAZ24w=";
    };
  };

  "nerdtree" = buildVimPluginFrom2Nix {
    name = "nerdtree";
    src = fetchgit {
      url = "https://github.com/preservim/nerdtree";
      rev = "0cb04e9245b000daf32f04aae5f606011a6aa3b5";
      sha256 = "BeERQxXYJKiWAlY73XujfCYtQxSrNLc2VHhQwfgRmuc=";
    };
  };

  "tagbar" = buildVimPluginFrom2Nix {
    name = "tagbar";
    src = fetchgit {
      url = "https://github.com/preservim/tagbar";
      rev = "5d6990e4fc5b3e3b88a3af90146f2561c4f6d828";
      sha256 = "PzaXLgHURp5Xw85vPe9uJqSATKGohja9NvM6ehHfFCQ=";
    };
  };

  "coc" = buildVimPluginFrom2Nix {
    name = "coc";
    src = fetchgit {
      url = "https://github.com/neoclide/coc.nvim";
      rev = "e10877749538a9875e359abe69974b0d0ca697ca";
      sha256 = "sha256-EHoflBq1C1sPE+7Jhou+6xjKbS/tfXSV5EWPHUSXOnY=";
    };
  };

  "rust-analyzer" = buildVimPluginFrom2Nix {
    name = "rust-analyzer";
    src = fetchgit {
      url = "https://github.com/fannheyward/coc-rust-analyzer";
      rev = "4491ad48ebe3149e33903d5ec19a79f044e45ffc";
      sha256 = "sha256-wOalGxQB5038RO38X82t6OGd8Fc29h+cFkmS+SstZpM=";
    };
  };

  "ycm" = buildVimPluginFrom2Nix {
    name = "YouCompleteMe";
    src = fetchgit {
      url = "https://github.com/ycm-core/YouCompleteMe";
      rev = "cc9a3ae3efdcc7d038aab0620ea28882533c236c";
      sha256 = "sha256-+HJqdAGYBMvNZ5Fbb/L259nVET5KpJOhYfKdGj1mteA=";
    };
  };
  "rust" = buildVimPluginFrom2Nix {
    name = "rust";
    src = fetchgit {
      url = "https://github.com/rust-lang/rust.vim";
      rev = "889b9a7515db477f4cb6808bef1769e53493c578";
      sha256 = "sha256-70kp644jOtJ4wguty/SUFX+YEsoxW12LGg3vZh7BdPY=";
    };
  };
  "vimcord" = buildVimPluginFrom2Nix {
    name = "vimcord";
    src = fetchgit {
      url = "https://github.com/Stoozy/vimcord";
      rev = "6e82b783bdd19be827b6c47696907ccc72ecb053";
      sha256 = "sha256-krCp2JEnHm+5ElVVol3F2QzFuYsJJMVxAD5bAA72AQc=";
    };
  };
  "doxygen" = buildVimPluginFrom2Nix {
    name = "doxygen";
    src = fetchgit {
      url = "https://github.com/vim-scripts/DoxygenToolkit.vim";
      rev = "afd8663d36d2ec19d26befdb10e89e912d26bbd3";
      sha256 = "sha256-uaA48i+lhwvYP6PGH4lTBaJh0Lnkda+lxNASKUCkSP0=";
    };
  };
  "spacecamp" = buildVimPluginFrom2Nix {
    name = "spacecamp";
    src = fetchgit {
      url = "https://github.com/jaredgorski/spacecamp";
      rev = "8945b4a2bfaaa16fbcee9f1d7c00cb9c1256b591";
      sha256 = "sha256-oRk5K/yuPj7EHteG/oRMq8pVmoiXzOv+9yVgONtlp7A=";
    };
  };
  "airline" = buildVimPluginFrom2Nix {
    name = "vim-airline";
    src = fetchgit {
      url = "https://github.com/vim-airline/vim-airline";
      rev = "ff7352e4bff02eb600a136b6fd741404f3195371";
      sha256 = "sha256-xQcg3C+W7jbKA6WRhxB0qbfRI5S6ZO1YkG6oFCVCR5o=";
    };
  };
  "copilot" = buildVimPluginFrom2Nix {
    name = "copilot";
    src = fetchgit {
      url = "https://github.com/github/copilot.vim";
      rev = "5b19fb001d7f31c4c7c5556d7a97b243bd29f45f";
      sha256 = "sha256-mHwK8vw3vbcMKuTb1aMRSL5GS0+4g3tw3G4uZGMA2lQ=";
    };
  };
}
