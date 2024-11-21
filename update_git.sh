echo "Copying nixconfigs to sys"
sudo cp -rf /etc/nixos/ ./nixos-backup/
echo "Stowing"
stow .
echo "Git add"
git add .
read -p "Commit Message: " commitmessage
git commit -m "$commitmessage"
git push origin master

read -p "NixOS Rebuild? [Y/n]? " -n 1
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
sudo nixos-rebuild switch --flake /etc/nixos#default
fi
