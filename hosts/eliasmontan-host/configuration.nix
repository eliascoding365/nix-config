{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./main-user.nix
    ];

  main-user.enable = true;
  main-user.userName = "eliasmontan";

  # Essential system packages
  environment.systemPackages = with pkgs; [
    wget
    vim
    vscode
    git
    foot

    # Java and build tools
    openjdk21
    jetbrains.idea-community-src
    gradle
    maven
    spring-boot-cli
  ];

  # Enable Home Manager for the user
  home-manager.users.eliasmontan = import ./home.nix;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking settings
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone and localization
  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ALL = "pt_BR.UTF-8";
  };

  # Keyboard layout
  console.keyMap = "br-abnt2";

  # Sound and multimedia
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Main user settings
  users.users.eliasmontan = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;
  

  # Set system state version
  system.stateVersion = "24.11"; 
}
