#sys shortucts
alias sudonix='sudo nixos-rebuild switch --flake /etc/nixos#default'
alias cleannix='sudo nix-collect-garbage -d'
alias dotbackup='git --git-dir=$HOME/Dot_files --work-tree=$home'

#youtube cli
alias yt='kitty -e ytfzf -tl --sort-by=view_count --ytdl-opts=248+bestaudio/best -T kitty'
alias ytsubs='kitty -e ytfzf -tcSI --sort --ytdl-opts=248+bestaudio/best -T kitty'

# Add .NET Core SDK tools
export PATH="$PATH:/home/daniel/.dotnet/tools"
