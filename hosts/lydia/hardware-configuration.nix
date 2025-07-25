# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "uas" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7537-0FFE";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/d7fb6d0b-24e2-41a0-8071-3a67d1b96f24";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress-force=zstd" "noatime" "ssd" ];
      neededForBoot = true;
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/d7fb6d0b-24e2-41a0-8071-3a67d1b96f24";
      fsType = "btrfs";
      options = [ "subvol=home" "compress-force=zstd" "ssd" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/d7fb6d0b-24e2-41a0-8071-3a67d1b96f24";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress-force=zstd" "noatime" "ssd" ];
      neededForBoot = true;
    };

  fileSystems."/etc/nixos" =
    { device = "/dev/disk/by-uuid/d7fb6d0b-24e2-41a0-8071-3a67d1b96f24";
      fsType = "btrfs";
      options = [ "subvol=nixos-config" "compress-force=zstd" "noatime" "ssd" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp12s0u3.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp11s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
