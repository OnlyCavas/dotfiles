{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      zed = "zeditor";

      rebuild = "nixos-rebuild switch --flake ~/nixos-dotfiles#$(hostname)";
      update = "cd ~/nixos-dotfiles && nix flake update && rebuild";
      config = "$EDITOR ~/nixos-dotfiles/";

      emacs-reload = "systemctl --user stop emacs && systemctl --user start emacs";
      emacs-reload-conf = "doom sync && emacs-reload";

      podman-start = "systemctl --user start podman.socket";
      podman-stop = "systemctl --user stop podman.socket";

      t = "tmux";
      ta = "tmux a";
      tn = "tmux new -s";
      tm = "tmux attack || tmux new";

      set-wal = "wal -i";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      container-enter() {
        local container_id=$(docker ps | grep "$1" | awk '{print $1}' | head -n 1)

        if [ -z "$container_id" ]; then
            echo "Error: No container found matching '$1'"
            return 1
        fi

        docker exec -it "$container_id" /bin/sh
      }

      emacs-open() {
        emacsclient -c -e "(dired \"$1\")"
      }

      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.foot.enable = true;

  home.packages = with pkgs; [
    tmux
    unzip
    btop
    neofetch
  ];
}
