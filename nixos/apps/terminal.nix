{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
kitty
  ]

  programs.zsh = {
enable = true;
  };
}