{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./gtk.nix
    ./neofetch
    ./vscode.nix
    ./xdg.nix
    ./zathura.nix
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
    feh.enable = true;
  };

  home.packages = with pkgs; [
    _1password-gui
    catppuccin-gtk
    desktop-file-utils
    google-chrome
    imlib2Full
    libnotify
    obsidian
    rambox
    signal-desktop
    xdg-utils
    yubikey-manager
  ];
}
