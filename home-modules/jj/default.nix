{...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      ui = {
        paginate = "never";
      };
      user = {
        email = "karpfen@karpfen.dev";
        name = "Karpfen";
      };
    };
  };
}
