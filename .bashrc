#sys shortucts
alias sudonix='sudo nixos-rebuild switch --flake /etc/nixos#default'
alias cleanix='sudo nix-collect-garbage -d'
alias dotbackup='cd ~/dotfiles && ./update_git.sh && cd'

alias neofetch='nix-shell -p fastfetch --run fastfetch'

alias mi='micro'
alias dot='cd ~/dotfiles'
export "MICRO_TRUECOLOR=1"
