{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "<Your Name>";
    userEmail = "<Email>";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
