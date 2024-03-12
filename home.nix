{ config, pkgs, ... }:

{
  programs = {
    git = {
        enable = true;
        userName = "TheBitStick";
        userEmail = "the@bitstick.rip";
    };
    neovim = {
      enable = true;
    };
    nushell = {
      enable = true;
      extraConfig = ''
      $env.config.show_banner = false

      $env.EDITOR = "nvim"
      $env.VISUAL = "zed"

      def clean [] {
          nix-collect-garbage -d
      }

      def gc [url] {
          cd ~/Developer/Git
          git clone $url
      }
      '';
      shellAliases = {
        cat = "bat --plain --paging=never";
        editv = "zed";
        sedit = "sudo nvim";
        edit = "nvim";
        vim = "nvim";
      };
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
