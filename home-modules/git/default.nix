{...}: {
  programs.git = {
    enable = true;
    userName = "Karpfen";
    userEmail = "karpfen@karpfen.dev";
    aliases = {
      ds = "diff --staged";
      l = "log --color --graph --pretty=slog";
      lg = "log --color --graph --pretty=lg --abbrev-commit";
      am = "commit --amend --no-edit";
      wdiff = "diff -w --word-diff=color --ignore-space-at-eol";
      as = "add -u";
    };
    extraConfig = ''
    [pretty]
    lg = format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset
    slog = format:%C(yellow)%h %Cred%as %Cblue%an%Cgreen%d %Creset%s
    bw = format:%h | %as | %>(20,trunc)%d%x09%s
    '';
  };
}
