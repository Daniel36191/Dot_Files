[//]: <> (ctl+shift+V  is the open preview)
# My Dotfiles



## Installation

Add These lines to current nix config
```nix
#Flatpacks
  services.flatpak.enable = true;
  xdg.portal.wlr.enable = true;
environment.systemPackages = with pkgs; [
    stow
    git
];
```
Install with git to home folder

```bash
git clone
./install.sh
```