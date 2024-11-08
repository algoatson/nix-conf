{ pkgs, ... }:

with pkgs;

let myVim = vim_configurable.customize {
  name = "vim";

  vimrcConfig = {
    # import vimrc
    customRC = builtins.readFile ./.vimrc;

    # make plugins available to vam
    vam.knownPlugins = pkgs.vimPlugins // import ./vimPlugins.nix;
    vam.pluginDictionaries = [
      {
        names = [
          "ycm"
          "nerdtree"
          "rust-analyzer"
          "rust"
          "doxygen"
          "spacecamp"
          "airline"
          "copilot"
          # ...
        ];
      }
    ];
  };
};

# include our customized vim package in systemPackages
in {
  environment.systemPackages = with pkgs; [ myVim ];
  # set vim as default editor
  environment.variables = { EDITOR = "vim"; };
}
