{...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      ui = {
        paginate = "never";
	default-command = "log";
      };
      user = {
        email = "karpfen@karpfen.dev";
        name = "Karpfen";
      };
    };
  };
}
