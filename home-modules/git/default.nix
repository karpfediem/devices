{...}: {
  programs.git = {
    enable = true;
    userName = "Karpfen";
    userEmail = "karpfen@karpfen.dev";
    aliases = {
      c = "commit";
      cm = "commit -m";
      ds = "diff --staged";
      l = "log --color --graph --pretty=slog";
      lg = "log --color --graph --pretty=lg --abbrev-commit";
      amend = "commit --amend --no-edit";
      wdiff = "diff -w --word-diff=color --ignore-space-at-eol";
      as = "add -u";
      aa = "add .";
      l1 = "log -1 --pretty=slog";
      l5 = "log -5 --pretty=slog";
      slog = "log --pretty=slog";
      slogbw = "log --pretty=bw";
      glog = "log --graph --pretty=slog";
      outgoing = "log --pretty=slog @{u}..";
      incoming = "log --pretty=slog HEAD..@{upstream}";
    };
    extraConfig = {
      pretty = {
        lg = "format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset";
        slog = "format:%C(yellow)%h %Cred%as %Cblue%an%Cgreen%d %Creset%s";
        bw = "format:%h | %as | %>(20,trunc)%d%x09%s";
      };
    };
  };
}
