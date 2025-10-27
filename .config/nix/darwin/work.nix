{ pkgs, ... }:
{
  # Point to Zscaler Root CA
  security.pki.certificateFiles = [ "/etc/ssl/certs/ZscalerRootCertificate-2048-SHA256.crt" ];

  environment.systemPackages = with pkgs; [
    amazon-q-cli
    bunster
    cilium-cli
    helm-docs
    nodejs_24
    linkerd_edge
    terraform
  ];

  homebrew = {
    brews = [
    ];
    taps = [
      "deskflow/homebrew-tap"
    ];
    casks = [
      "arc"
      "cursor"
      "deskflow"
      "docker-desktop"
      "slack"
      "vscodium"
      "zen@twilight"
    ];
  };

  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Spotify.app"
      "/Applications/Zen.app"
      "/Applications/Twilight.app"
      "/Applications/Arc.app"
      "/Applications/Slack.app"
      "/Applications/Microsoft Outlook.app"
      "/Applications/Ghostty.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/Obsidian.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/App Store.app"
      "/System/Applications/System Settings.app"
    ];
  };
}
