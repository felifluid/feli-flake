{pkgs, ...}: {
  home = {
    username = "feli";
    homeDirectory = "/home/feli";
  };

  home.packages = with pkgs; [xclip tree ripgrep typst vesktop signal-desktop spotify obsidian];

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "Alacritty.desktop"
        "org.gnome.Nautilus.desktop"
        "codium.desktop"
        "obsidian.desktop"
        "spotify.desktop"
        "vesktop.desktop"
      ];
    };
    "org/gnome/desktop/background" = {
      "picture-uri" = "file:///home/feli/.local/share/backgrounds/2025-06-10-11-04-08-nix-wallpaper-nineish-catppuccin-frappe-alt.png";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
  };

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Feli Berner";
      userEmail = "coding@felifluid.de";
    };

    alacritty.enable = true;
    fzf.enable = true; # enables zsh integration by default
    starship.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "direnv"
        ];
      };
    };

    neovim = {
      enable = true;
    };

    firefox = {
      enable = true;
      languagePacks = ["de" "en-US"];
      policies = {
        ExtensionSettings = with builtins; let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/de-DE/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
          listToAttrs [
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
            (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
          ];
      };
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        kamadorueda.alejandra # nix formatter
        jeff-hykin.better-nix-syntax # nix syntax highlighting
        myriad-dreamin.tinymist # tinymist typst
        catppuccin.catppuccin-vsc-icons # catppuccin icons
        ms-python.python # python
      ];
      profiles.default.userSettings = {
        "workbench.iconTheme" = "catppuccin-frappe";
        "workbench.startupEditor" = "none";
        "editor.wordWrap" = "on";
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
        "alejandra.program" = "alejandra";
        "git.confirmSync"= false;
      };
    };
  };

  

  # TODO: move to flake
  services = {
    syncthing = {
      enable = true;
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
      # NOTE: this needs to be adjusted per device
      settings = {
        options = {
          urAccepted = -1;
          localAnnounceEnabled = true;
        };
        devices = {
          feli-pixel = {
            id = "BL3KB3Y-LGO6OZ7-KGNLKZJ-KOKC6WW-W3A7Z2Z-DESTCBG-GM7Z75Z-WJJQOAJ";
          };
          feli-tablet = {
            id = "FKKWTAI-B2QFTCK-WZ7R5DI-DCKAL44-QLBLA2K-677UUIE-DDL6SNO-LWYNZAY";
          };
          feli-deskwin = {
            id = "TPZBKYM-VHQXLKD-ROHGAND-G4YVVRZ-PXU3BIC-3CRW5LM-PCJSMIX-46P53AD";
          };
        };
        folders = {
          # TODO: make var for "all devices"
          "Dokumente" = {
            id = "gvkvg-7j6xx";
            path = "/home/feli/Dokumente";
            devices = ["feli-pixel" "feli-tablet" "feli-deskwin"];
          };
          "Bilder" = {
            id = "tlbah-ttkfa";
            path = "/home/feli/Bilder";
            devices = ["feli-pixel" "feli-tablet" "feli-deskwin"];
          };
          "Musik" = {
            id = "gm6ch-pactp";
            path = "/home/feli/Musik";
            devices = ["feli-pixel" "feli-tablet" "feli-deskwin"];
          };
          "Videos" = {
            id = "t92i7-u6psp";
            path = "/home/feli/Videos";
            devices = ["feli-pixel" "feli-tablet" "feli-deskwin"];
          };
        };
      };
    };
  };

  # Create empty ~/Code folder
  home.file."Code/.info" = {
    enable = true;
    text = "This directory was created automatically by Home Manager.";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
