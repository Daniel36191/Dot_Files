# Use GNU Stow to symlink dotfiles
stow .

# Prompt for commit message
echo "Commit Name:"
read commit_name

# Add changes to Git
git add .

# Commit with the provided message
git commit -m "$commit_name"

# Push to the master branch
git push origin master

read -p "Backup Nix cfg/s" yn

case $yn in 
	[yY] ) sudo cp -fr /etc/nixos/ ./;
		break;;
	[nN] ) echo exiting...;
		exit;;
	* ) echo invalid response;;
esac

