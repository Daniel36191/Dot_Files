# Prompt for backing up Nix configurations
read -p "Backup Nix cfg/s (y/n)? " yn

case $yn in 
    [yY] ) 
        echo "Backing up Nix configurations..."
        sudo cp -fr /etc/nixos/ ./
        echo "Backup completed."
        ;;
    [nN] ) 
        echo "No backup taken."
        ;;
    * ) 
        echo "Invalid response. Exiting."
        exit 1
        ;;
esac

read -p "Upload dot/s (y/n)? " yn2

case $yn2 in 
    [yY] ) 
        echo "Uploading to git..."
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
        echo "Upload completed!"
        ;;
    [nN] ) 
        echo "No upload done."
        ;;
    * ) 
        echo "Invalid response. Exiting."
        exit 1
        ;;
esac