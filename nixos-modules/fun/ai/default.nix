{ pkgs, lib, ... }: {
  services.comfyui = {
    enable = true;
    host = "0.0.0.0";
    openFirewall = false;
    models = builtins.attrValues pkgs.nixified-ai.models;
    customNodes = with pkgs.comfyuiPackages; [
      comfyui-gguf
      comfyui-impact-pack
    ];
  };
  systemd.services.comfyui.wantedBy = lib.mkForce [ ];
}
