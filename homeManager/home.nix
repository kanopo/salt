{ pkgs, ... }:

{

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    btop
    neofetch
    firefox
    librewolf
    sway
    waybar
    telegram-desktop
    alacritty
    swaylock
    swayidle
    wl-clipboard
    wayland
    git
    brightnessctl
    pulseaudio
    wofi
    keepassxc
    dropbox
    texlive.combined.scheme-medium
    gnome.seahorse
    awscli2
    yt-dlp
    wl-color-picker
    fd
    ripgrep
    fzf
    wf-recorder
    adw-gtk3
    swaybg
    wlsunset
    imv
    xss-lock
    mpv
    wob
    mako
    spotify
    gnome.nautilus
    docker
    docker-compose
    zathura
    google-chrome
    xdg-user-dirs
    tmux
    nodejs_20
    python311
    python311Packages.pip
    polkit_gnome
    wlogout
    pavucontrol
    sway-contrib.grimshot
    networkmanagerapplet
    clipman
    gnumake
    gnupg

  ];

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_ENABLE_WAYLAND = "1";
  };

}

