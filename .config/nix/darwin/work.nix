{ pkgs, ... }:
{
  # Point to Zscaler Root CA
  security.pki.certificateFiles = [ "/etc/ssl/certs/ZscalerRootCertificate-2048-SHA256.crt" ];

  environment.systemPackages = with pkgs; [
    amazon-q-cli
    helm-docs
  ];

  homebrew = {
    casks = [
      "arc"
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
      "/Applications/Slack.app"
      "/Applications/Microsoft Outlook.app"
      "/Applications/Arc.app"
      "/Applications/Ghostty.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/Obsidian.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/App Store.app"
      "/System/Applications/System Settings.app"
    ];
  };
}
