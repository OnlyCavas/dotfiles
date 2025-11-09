{ config, pkgs, ... }:

{
  home.sessionVariables = {
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
  };

  home.packages = with pkgs; [
    # software
    insomnia
    gh
    claude-code
    lazygit
    just

    # csharp
    jetbrains.rider
    dotnet-sdk_9

    # docker-compose and yaml relative
    yaml-language-server

    # lua
    lua-language-server

    # elixir
    elixir
    erlang
    inotify-tools
    # elixir-ls
    lexical
    semgrep

    # golang
    go
    gopls
    gotools

    # nix
    nixd
    nixpkgs-fmt

    # rust
    rustup

    # clang
    cmake
    gcc
    gnumake
    libtool
  ];
}
