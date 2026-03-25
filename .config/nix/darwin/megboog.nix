{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    age
    ffmpeg
    rmpc
    sketchybar
  ];

  homebrew = {
    casks = [
      "ableton-live-suite@11"
      "balenaetcher"
      "clipgrab"
      "foobar2000"
      "google-chrome"
      "jagex"
      "kdenlive"
      "ledger-wallet"
      "messenger"
      "raycast"
      "steam"
      "teamviewer"
      "telegram"
      "thunderbird"
      "tidal"
    ];
  };

  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Zen.app"
      "/Applications/Spotify.app"
      "/Applications/Ghostty.app"
      "/Applications/Obsidian.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/System Settings.app"
    ];
  };
}
