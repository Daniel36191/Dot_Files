echo "Copying nixconfigs to sys"
sudo cp -rf ./nixos /etc/nixos/
echo "Stowing"
stow .
echo "Git add"
git add .
read -p "Commit Message: " commitmessage
git commit -m "$commitmessage"
git push origin master