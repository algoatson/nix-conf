{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python311Packages.python-lsp-server
    nodePackages_latest.nodemon
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.yaml-language-server
    nodePackages_latest.dockerfile-language-server-nodejs
    pyright
    typos-lsp
    # vue-language-server
    sumneko-lua-language-server
    marksman
    nil
    nixd
    nixfmt-classic
    zls
    gopls
    delve
    ghc
    bear # this is for clangd.
  ];
}
