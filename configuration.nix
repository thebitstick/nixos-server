{ config, lib, pkgs, ... }:

{
  imports = [
    ./hosts/pomu/hardware-configuration.nix
    ./linux.nix
  ];

  networking = {
    hostName = "pomu";
    nameservers = [
      # Cloudflare DNS
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
  };

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "Administrator";
    shell = pkgs.nushell;
  };

  environment = {
    systemPackages = with pkgs; [
      # Terminal Utilities
      inetutils
      neovim
      nmap
      wget

      # Terminal Replacement Utilities
      bat
      du-dust
      duf
      eza
      fd
    ];

    variables = {
      EDITOR = "nvim";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  system.stateVersion = "23.05";
}
