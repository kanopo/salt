{ pkgs, ... }:

{

  home.stateVersion = "23.05";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DroidSansMono"
        ];
      })
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
    nodePackages.pnpm
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
    pinentry
    gccgo
    unzip
    wget
    cargo
    luarocks
    jdk
    tree-sitter
    exa
    ltex-ls
  ];

  # home.xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #
  #   };
  # };


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


}

