# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
nixpkgs.overlays = [ (import ./pkgs) ];

imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Home manager
    ./home.nix
  ];

# Bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

networking.hostName = "pwnixos"; # Define your hostname.

# Enable networking
networking.networkmanager.enable = true;

# Set your time zone.
time.timeZone = "Europe/Paris";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";

i18n.extraLocaleSettings = {
  LC_ADDRESS = "fr_FR.UTF-8";
  LC_IDENTIFICATION = "fr_FR.UTF-8";
  LC_MEASUREMENT = "fr_FR.UTF-8";
  LC_MONETARY = "fr_FR.UTF-8";
  LC_NAME = "fr_FR.UTF-8";
  LC_NUMERIC = "fr_FR.UTF-8";
  LC_PAPER = "fr_FR.UTF-8";
  LC_TELEPHONE = "fr_FR.UTF-8";
  LC_TIME = "fr_FR.UTF-8";
};

# Enable the X11 windowing system.
services.xserver.enable = true;

# Enable the GNOME Desktop Environment.
services.xserver.displayManager.gdm.enable = true;
services.xserver.desktopManager.gnome.enable = true;

# Configure keymap in X11
services.xserver = {
  layout = "us";
  xkbVariant = "";
};

# Enable CUPS to print documents.
services.printing.enable = true;

# Enable sound with pipewire.
sound.enable = true;
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};

# Fonts
fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "SourceCodePro"  ]; })
];

# Sudo
security.sudo = {
  enable = true;
  extraRules = [{
    commands = [
      {
        command = "${pkgs.systemd}/bin/systemctl suspend";
        options = [ "NOPASSWD" ];
      }
      {
        command = "${pkgs.systemd}/bin/reboot";
        options = [ "NOPASSWD" ];
      }
      {
        command = "${pkgs.systemd}/bin/poweroff";
        options = [ "NOPASSWD" ];
      }
    ];
    groups = [ "wheel" ];
  }];
};

# Docker
virtualisation.docker.enable = true;

# Virtualbox
virtualisation.virtualbox.host.enable = true;
#virtualisation.virtualbox.host.enableExtensionPack = true;
users.extraGroups.vboxusers.members = [ "micronoyau" ];

# Allow unfree packages
nixpkgs.config.allowUnfree = true;

nix.settings.extra-experimental-features = "nix-command flakes";

nixpkgs.config.permittedInsecurePackages = [
  "zotero-6.0.26"
];

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.micronoyau = {
  isNormalUser = true;
  description = "micronoyau";
  extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" "dialout" ];
  packages = with pkgs; [
    # Applications
    firefox
    # ungoogled-chromium
    zotero
    anki
    spotify
  ];
};

# List packages installed in system profile. To search, run:
# $ nix search wget
environment.systemPackages = with pkgs; [
  # Text editors
  vim
  neovim

  # Basic utilities
  tree
  htop
  file
  ascii
  findutils
  mlocate
  pciutils
  unzip
  xclip
  tmux
  pinentry
  ripgrep
  poppler_utils
  inkscape
  libreoffice
  hexdiff
  usbutils
  screen

  # LaTeX
  texlive.combined.scheme-full

  # Network
  wireshark
  wirelesstools
  traceroute
  wget
  inetutils
  dig
  openvpn
  iptstate
  nftables

  # Binaries
  gcc_multi
  glibc
  glibc_multi
  patchelf
  gnumake
  cmake

  # Libraries
  zlib

  # Dev
  git
  docker
  docker-compose
  nodejs_20
  yarn

  # Arduino
  arduino

  # Virtualisation / emulation
  qemu
  # virtualbox # Seems to be included by default

  # Security
  gnupg
  keepassxc
  openssl

  # Python
  python311
  python311Packages.virtualenv
  python311Packages.pip

  # Rust
  rustc
  cargo

  # Java
  jdk17

  # Android
  android-studio
  android-tools

  # Math
  sage
  coq
  coqPackages.coqide

  # Security
  # OSINT
  exiftool
  sherlock
  # Stegano
  sonic-visualiser
  # Recon
  nmap
  masscan
  dirb
  gobuster
  ffuf
  dnsrecon
  sublist3r
  # MITM
  bettercap
  # Password cracking
  thc-hydra
  john
  # Web
  burpsuite
  # Exploits
  metasploit
  # Pwn / reverse
  gdb
  ghidra
  ida-free
  radare2
  ropgadget
];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
programs.wireshark.enable = true;

# Bash
programs.bash.shellAliases = {
    xcompile-arm-32 = "nix-shell ~/.config/xcompile/shell-arm-32.nix";
    xcompile-riscv-64 = "nix-shell ~/.config/xcompile/shell-riscv-64.nix";
    xcompile-mips-32 = "nix-shell ~/.config/xcompile/shell-mips-32.nix";
};

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "23.05"; # Did you read the comment?
system.autoUpgrade.enable = true;
system.autoUpgrade.allowReboot = true;
}

