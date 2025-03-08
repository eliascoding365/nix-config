{ config, pkgs, ... }:

{
  # Home Manager configuration
  home.username = "eliasmontan";
  home.homeDirectory = "/home/eliasmontan";
  home.stateVersion = "24.11"; # Do not change unless necessary

  # Enable Hyprland and Kitty (Hyprland default terminal)
  wayland.windowManager.hyprland.enable = true;
  programs.kitty.enable = true;

  # Hyprland configuration
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # Workspaces: Binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
  };

  # Installed packages
  home.packages = with pkgs; [
    alacritty
    firefox
    neovim
    openjdk21
    rofi
    waybar
  ];

  # Environment variables
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };

  # Dotfile management (add custom configs here)
  home.file = {
    # Example:
    # ".config/waybar/config".source = ./dotfiles/waybar-config;
  };

  # Enable Home Manager itself
  programs.home-manager.enable = true;
  programs.zsh.enable = true;

}
