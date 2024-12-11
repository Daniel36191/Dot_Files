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
echo "Applying Configs"
stow .