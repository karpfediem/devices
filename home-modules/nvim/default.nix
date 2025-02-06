{inputs, lib, ...}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    imports = [ inputs.Neve.nixvimModule ];
    plugins.fidget.enable = lib.mkForce false;
  };
}
