{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.micronoyau = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "18.09";

    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */

    # git
    programs.git = {
      enable = true;
      userName = "micronoyau";
      userEmail = "leo.lf.dk@gmail.com";
    };

    # neovim
    xdg.configFile.nvim = {
      source = ./config/nvim;
      recursive = true;
    };

    # gef
    xdg.configFile.gef = {
      source = ./config/gef;
    };

    # Cross-comilation
    xdg.configFile.xcompile = {
      source = ./config/xcompile;
    };

    xdg.dataFile.seclists = {
      source = builtins.fetchGit {
        url = "https://github.com/danielmiessler/SecLists.git";
        rev = "395c945627196b6172e6e83a014c964f805e8d48";
      };
    };

    home.file.".gdbinit".text = ''
      source ~/.config/gef/gefscript.py
    '';

    # tmux
    home.file.".tmux.conf".text = ''
      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection

      unbind C-b
      set-option -g prefix C-w
      bind-key C-w send-prefix
      bind \- split-window -v
      bind | split-window -h

      bind < resize-pane -L 10
      bind > resize-pane -R 10
      bind - resize-pane -D 10
      bind + resize-pane -U 10
    '';

  };
}
