{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-74b37b7b-20f4-4343-92b2-5a1ef2feec5c".device = "/dev/disk/by-uuid/74b37b7b-20f4-4343-92b2-5a1ef2feec5c";
  boot.initrd.luks.devices."luks-74b37b7b-20f4-4343-92b2-5a1ef2feec5c".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "yoga"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Configure keymap in X11
  services = {
    xserver = {
      enable = true;
      layout = "it";
      xkbVariant = "";
      displayManager = {
        gdm.enable = true;
      };
      videoDrivers = [ "intel" ];
      libinput = {
        enable = true;
	touchpad.tapping = true;
      };
    };
    blueman.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      alsa.support32Bit = true;
    };

    undervolt = {
      enable = true;
      gpuOffset = 0;
      coreOffset = -50;
      analogioOffset = -50;
    };

    gnome.gnome-keyring.enable = true;
  };
  programs.gnupg.agent = {
        enable = true;
  };


  hardware.bluetooth.enable = true;


  # qt = {
  #   enable = true;
  #   platformTheme = "adwaita-dark";
  #   style = "adwaita-dark";
  # };

  security.sudo.wheelNeedsPassword = false;
  security.pam.services.gdm.enableGnomeKeyring = true;


  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
      gc = {
        automatic = true;
	      dates = "weekly";
	      options = "--delete-older-than 7d";
      };
  };


  # Configure console keymap
  console.keyMap = "it";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dmo = {
    isNormalUser = true;
    description = "Dmitri Ollari Ischimji";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    packages = with pkgs; [
      neofetch
      firefox
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
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    xdg-utils
    intel-gpu-tools
    intel-media-driver
    vaapiIntel
    microcodeIntel
    dbus
    gnome.gnome-keyring

  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    MOZ_ENABLE_WAYLAND = "1";
    GPG_TTY="$(tty)";
  };

  programs.sway.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  security.polkit.enable = true;
  programs.zsh.enable = true;
  users.users.dmo.shell = pkgs.zsh;

  hardware.cpu.intel.updateMicrocode = true;

  virtualisation.docker.enable = true;
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
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
