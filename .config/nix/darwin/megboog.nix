{ pkgs, ... }:
{
  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Zen.app"
      "${pkgs.spotify}/Applications/Spotify.app"
      "/Applications/Ghostty.app"
      "${pkgs.obsidian}/Applications/Obsidian.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/App Store.app"
      "/System/Applications/System Settings.app"
    ];
  };
}
