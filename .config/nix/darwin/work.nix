{ pkgs, ... }:
{
  # Point to CA
  security.pki.certificateFiles = [ "/etc/ssl/certs/ca-certificates.crt" ];

  homebrew = {
    casks = [
      "arc"
      "docker-desktop"
      "slack"
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
