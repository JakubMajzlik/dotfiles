# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  hardware.enableAllFirmware  = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  systemd.user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];
  hardware.pulseaudio.enable = false;

  # Display manager
  services.displayManager = {
    ly.enable = true;
    defaultSession = "none+i3";
  };
  
  # Window Manager
  services.xserver.windowManager = {
    awesome = {
      enable = false;
      package = pkgs.awesome;
      luaModules = with pkgs.luaPackages; [
        luarocks
	luadbi-mysql
      ];
    };
    i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
     	polybar
     ];
    };
  };

  #Aliases
  environment.shellAliases = {
    nixcfg = "sudo nvim /etc/nixos/configuration.nix";
    i3cfg = "nvim ~/.config/i3/config";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jakub = {
    isNormalUser = true;
    description = "Jakub";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    ghostty
    brave
    rofi
    feh
    pavucontrol
    gcc
    bat
    nodejs
    killall
    unzip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  
  # Fonts 
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  systemd.services.hidAppleFnMode = {
       description = "Set hid_apple fnmode parameter";
       wants = [ "sys-module-hid_apple.mount" ];
       after = [ "sys-module-hid_apple.mount" "local-fs.target" ];
       serviceConfig = {
         ExecStart = [
           "/bin/sh" "-c" "echo" "2" ">" "/sys/module/hid_apple/parameters/fnmode"
         ];
         Type = "oneshot";
         RemainAfterExit = true;
       };
     };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
