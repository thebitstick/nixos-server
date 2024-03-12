{ config, pkgs, ... }:

{
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    systemPackages = with pkgs; [
      git
      mcrcon
    ];
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
    };
  };

  services = {
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      virtualHosts = {
        "bitstick.rip" = {
          forceSSL = true;
          enableACME = true;
          root = "/var/www/bitstick.rip";
        };
        "huicochea.moe" = {
          forceSSL = true;      
          enableACME = true;
          root = "/var/www/huicochea.moe";
        };
        "www.bitstick.rip" = {
          forceSSL = true;
          enableACME = true;
          globalRedirect = "bitstick.rip";
        };
        "www.huicochea.moe" = {
          forceSSL = true;
          enableACME = true;
          globalRedirect = "huicochea.moe";
        };
      };
    };
    minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = true;
      declarative = true;
      serverProperties = {
        server-port = 25565;
	gamemode = "survival";
	motd = "\\u00a7l\\u00a7o\\u00a7nDeclarative Server\\u00a7r\\u00a7l\\u00a7n powered by NixOS";
	max-players = 5;
	level-seed = "nixos";
	enable-rcon = true;
	"rcon.password" = "nixos";
      };
    };
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    tailscale.enable = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "the@bitstick.rip";
    defaults.group = "nginx";
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
