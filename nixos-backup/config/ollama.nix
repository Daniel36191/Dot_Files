{ config, pkgs, ... }:
{
  services.ollama = {
  enable = true;
  acceleration = "cuda";
};
programs.bash.shellAliases = {
  mgpt = "tgpt -i --provider ollama --model qwen2-math";
};
environment.systemPackages = with pkgs; [
  tgpt
];
}