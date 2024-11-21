#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

# Add bpainter user to sudo group
usermod -aG sudo bpainter

# Create .ssh directory and set permissions
mkdir -p /home/bpainter/.ssh
chown bpainter:bpainter /home/bpainter/.ssh
chmod 700 /home/bpainter/.ssh

# Add public SSH key (replace with your actual public key)
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7md2L6JRgWYeM1AZwqRf9py479YKGq2iIqw/hy3AIY bpainter@bpainter-lg" > /home/bpainter/.ssh/authorized_keys
chown bpainter:bpainter /home/bpainter/.ssh/authorized_keys
chmod 600 /home/bpainter/.ssh/authorized_keys

# Configure sudo without password for bpainter
echo "bpainter ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/bpainter
chmod 440 /etc/sudoers.d/bpainter

# Add Google Chrome repository and key
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Add VSCode repository and key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
rm packages.microsoft.gpg

# Add Bitwarden repository
curl -fsSL https://packages.bitwarden.com/github/deb/pubkey.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/bitwarden.gpg
echo "deb https://packages.bitwarden.com/github/deb/ stable main" > /etc/apt/sources.list.d/bitwarden.list

# Update package lists and upgrade existing packages
apt update
apt upgrade -y

# Install required packages
apt install -y \
    google-chrome-stable \
    xrdp \
    bitwarden \
    code

# Start and enable XRDP service
systemctl enable xrdp
systemctl start xrdp

echo "Installation complete!"
