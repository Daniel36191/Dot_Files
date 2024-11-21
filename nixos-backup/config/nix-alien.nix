{ pkgs, ... }:
{
programs = {
  nix-ld = {
enable = true;
    libraries = with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
];
  };
};
}