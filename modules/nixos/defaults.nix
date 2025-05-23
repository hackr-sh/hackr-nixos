{ ... }:
{
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true; # enable network manager
  time.timeZone = "America/Edmonton"; # set timezone
  i18n.defaultLocale = "en_CA.UTF-8"; # set locale
  services.xserver.enable = true; # enables x11
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nixpkgs.overlays = [
    (final: prev: {
      openssh = prev.openssh.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ../../patches/openssh.patch ];
        doCheck = false;
      });
    })
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
