{ config, pkgs, lib, ... }:

{
  home.username = "himavanth";
  home.homeDirectory = "/home/himavanth";

  # Packages to install for your user
  home.packages = with pkgs; [
    # Development
    git
    vim

    # CLI utilities
    htop
    ncdu
    eza
    unzip
    p7zip
    compose2nix

    # Others
    vlc
    zathura
    libreoffice
    vesktop
    spotify
    woeusb-ng
    google-chrome
    zapzap # Desktop whatsapp

    # Peripheral
    piper  # GUI for mouse/keyboard config
  ];

  # VS Code config
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default = {
      userSettings = {
        "window.splashScreen.enabled" = false;
        "telemetry.telemetryLevel" = "off";
        "editor.lineNumbers" = "relative";
        "editor.rulers" = [ 80 120 ];
        "editor.renderWhitespace" = "boundary";  # Show whitespace at word boundaries
        "editor.wordWrap" = "off";  # Disable word wrapping to see the rulers better
      };

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        vscodevim.vim
        charliermarsh.ruff
        dracula-theme.theme-dracula
        njpwerner.autodocstring
        christian-kohler.path-intellisense
        oderwat.indent-rainbow
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "save-as-root";
          publisher = "yy0931";
          version = "1.1.0";
          sha256 = "lpK4C5zfGEd4jd9XOBkyaw+J2rzpaYTDqyN8ebVDlTo=";
        }
      ];
    };
  };

  # Git config
  programs.git = {
    enable = true;
    userName = "Faust404";
    userEmail = "himavanth.reddy19@gmail.com";
    extraConfig = {
      credential.helper = "oauth";
      init.defaultBranch = "main";
    };
  };

  # Firefox config
  programs.firefox = {

    enable = true;
    profiles.default = {

      search = {
        force = true;
        default = "Kagi";

        engines = {
          "Kagi" = {
            urls = [
              {
                template = "https://kagi.com/search?";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };

      settings = {
        # Disable about:config warning
        "browser.aboutConfig.showWarning" = false;

        # Mozilla telemetry
        "toolkit.telemetry.enabled" = true;

        # Activity Stream
        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = true;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";

        # Addon recomendations
        "browser.discovery.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        # Crash reports
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;

        # Auto-decline cookies
        "cookiebanners.service.mode" = 2;
        "cookiebanners.service.mode.privateBrowsing" = 2;

        # Disable autoplay
        "media.autoplay.default" = 5;

        # Prefer dark theme
        "layout.css.prefers-color-scheme.content-override" = 0; # 0: Dark, 1: Light, 2: Auto

        # HTTPS only
        "dom.security.https_only_mode" = true;

        # Trusted DNS (TRR)
        "network.trr.mode" = 2;
        "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";

        # ECH - prevent TLS connections leaking request hostname
        "network.dns.echconfig.enabled" = true;
        "network.dns.http3_echconfig.enabled" = true;

        # Tracking
        "browser.contentblocking.category" = "standard";
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;

        # Fingerprinting
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.pbmode" = true;

        "privacy.firstparty.isolate" = false;

        # URL query tracking
        "privacy.query_stripping.enabled" = true;
        "privacy.query_stripping.enabled.pbmode" = true;

        # Prevent WebRTC leaking IP address
        "media.peerconnection.ice.default_address_only" = true;

        # Use Mozilla geolocation service instead of Google
        "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";

        # Disable password manager
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "signon.formlessCapture.enabled" = false;

        # Hardens against potential credentials phishing:
        # 0 = don’t allow sub-resources to open HTTP authentication credentials dialogs
        # 1 = don’t allow cross-origin sub-resources to open HTTP authentication credentials dialogs
        # 2 = allow sub-resources to open HTTP authentication credentials dialogs (default)
        "network.auth.subresource-http-auth-allow" = 1;
      };
    };
  };

  # home.persistence."/persist/home/himavanth" = {
  #   directories = [
  #     ".cache/mozilla/firefox"
  #     ".mozilla/firefox"
  #   ];
  #   allowOther = true;
  # };


  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
