{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.eliasmontan = {
    isNormalUser = true;
    description = "Elias Montan Dev";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
      "plugdev"

    ];
  
  packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };

  home-manager.users.eliasmontan = import ../../../home/eliasmontan/${config.networking.hostName}.nix;

}