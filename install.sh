read -p "Instll .nix/s? " yn

case $yn in 
    [yY] ) 
        sudo cp -fr ./nixos/ /etc/
        echo "Copied"
        echo "Rebuilding"
        sudo nixos-rebuild switch --flake /etc/nixos#default
        echo "Cleaning"
        sudo nix-collect-garbage -d
        echo "Done"
        ;;
    [nN] ) 
        echo ""
        ;;
    * ) 
        echo "Invalid response. Exiting."
        exit 1
        ;;
esac

read -p "Instll dot/s? " yn2

case $yn2 in 
    [yY] ) 
        stow .
        echo "Done"
        ;;
    [nN] ) 
        echo ""
        ;;
    * ) 
        echo "Invalid response. Exiting."
        exit 1
        ;;
esac

echo "Exiting"
exit 1