# https://github.com/nix-community/impermanence#module-usage
{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/var/lib/nixos"
    ];
    files = [
      # machine-id is used by systemd for the journal, if you don't persist this
      # file you won't be able to easily use journalctl to look at journals for
      # previous boots.
      # "/etc/machine-id"
    ];
    users.feli = {
      files = [
        ".zsh_history"
      ];
    };
  };
}
