{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ffmpeg
    mpd
    rmpc
  ];

  homebrew = {
    casks = [
      "ableton-live-suite@11"
      "balenaetcher"
      "clipgrab"
      "foobar2000"
      "jagex"
      "kdenlive"
      "ledger-live"
      "messenger"
      "raycast"
      "steam"
      "tailscale"
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
      "/System/Applications/App Store.app"
      "/System/Applications/System Settings.app"
    ];
  };
}
