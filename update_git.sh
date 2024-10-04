read -p "Copy Nixos Configs? (y/n): " yn1

case $yn1 in 
	[yY] ) sudo cp -rf /etc/nixos/. ~/dotfiles/nixos
esac


# Prompt for uploading dotfiles
read -p "Would you like to upload dotfiles? (y/n): " yn

case $yn in 
    [yY] ) 
        echo "Uploading to git..."
        
        # Use GNU Stow to symlink dotfiles
        if stow .; then
            # Prompt for commit message
            echo "Commit message:"
            read commit_name
            
            # Add changes to Git
            git add .
            
            # Commit with the provided message
            if git commit -m "$commit_name"; then
                # Push to the master branch
                if git push origin master; then
                    echo "Upload completed!"
                else
                    echo "Error pushing to Git."
                fi
            else
                echo "Error during commit."
            fi
        else
            echo "Error during stow operation."
        fi
        ;;
    [nN] ) 
        echo "No upload done."
        ;;
    * ) 
        echo "Invalid response. Exiting."
        exit 1
        ;;
esac
