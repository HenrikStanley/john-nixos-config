{ pkgs, desktop, ... }:
{
  imports = [
    (./. + "/${desktop}")

    ../dev

    ./alacritty.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
    ./zathura.nix
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    bambu-studio
    catppuccin-gtk
    desktop-file-utils
    ght
    (google-chrome.override {
      commandLineArgs = [
        # Workaround for log spam on video calls: https://issues.chromium.org/issues/331796411
        "--disable-gpu-memory-buffer-video-frames"
        "--ozone-platform-hint=auto"
      ];
    })
    libnotify
    loupe
    pamixer
    papers
    pwvucontrol
    todoist-electron
    xdg-utils
    xorg.xlsclients

    unstable.obsidian
    unstable.rambox
    unstable.signal-desktop
  ];

  fonts.fontconfig.enable = true;
}
