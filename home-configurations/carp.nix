{ pkgs, ezModules, osConfig, ... }:
let
  username = "carp";
in
{
  imports = [
    ezModules.direnv
    ezModules.git
  ];

  home = {
    username = osConfig.users.users.${username}.name or "${username}";
    stateVersion = "24.11";
    homeDirectory = osConfig.users.users.${username}.home or (
      if pkgs.stdenv.isDarwin then
        "/Users/${username}" else
        "/home/${username}"
    );

    packages = with pkgs; [
      neovim
    ];
  };

}
