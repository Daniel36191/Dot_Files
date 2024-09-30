read -p "Instll Nix? " yn

case $yn in 
    [yY] ) 
        echo ""
        sudo cp -fr /etc/nixos/ ./
        echo ""
        ;;
    [nN] ) 
        echo ""
        ;;
    * ) 
        echo "Invalid response. Exiting."
        exit 1
        ;;
esac