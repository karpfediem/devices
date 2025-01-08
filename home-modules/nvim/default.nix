{inputs, pkgs, system, ...}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    imports = [ inputs.Neve.nixvimModule ];
  };
}
