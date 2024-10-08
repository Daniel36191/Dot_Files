username=$(whoami)

echo "Giveing Write Priv Over Sys Configs"
sudo chown -R $username /etc/nixos
echo "Installing Nix Configs"
sudo cp -fr ./nixos/ /etc/
echo "Copied"
echo "Rebuilding"
sudo nixos-rebuild switch --flake /etc/nixos#default
#permissions for new user
sudo chown -R daniel /etc/nixos
echo "Cleaning"
sudo nix-collect-garbage -d
echo "Done"
echo "Installing Spotify"
flatpak install flathub com.spotify.Client
flatpak update --commit=097c01a29cc9a847993ef65cd6ceefa1f451c16dfa58422c7d82230be5bd6e60 com.spotify.Client
echo "Installing Proton-GE"
protonup
echo "Installing Waterfox"
flatpak install flathub net.waterfox.waterfox
echo "Applying Configs"
stow .