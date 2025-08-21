{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ffmpeg
    mpd
    rmpc
  ];

  homebrew = {
    casks = [
      "balenaetcher"
      "discord"
      "ledger-live"
      "scratch"
      "telegram"
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
