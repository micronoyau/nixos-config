rm -r /etc/nixos/*
cp -r * /etc/nixos/
rm -rf /etc/nixos/.git
rm /etc/nixos/LICENSE
rm /etc/nixos/README.md
rm /etc/nixos/update.sh
nixos-rebuild switch
