#!/bin/bash

RED= '\033[0;31m' #Red color
NC= '\033[0m' # No Color

# Function to check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Vagrant if not already installed
if ! command_exists vagrant; then
    echo "Vagrant is not installed. Installing Vagrant..."
    if [[ "$(uname -m)" == "arm64" ]]; then
        # Install Vagrant for M1 chip
        brew install vagrant --cask
    else
        # Install Vagrant for other architectures
        brew install vagrant
    fi
else
    echo "Vagrant is already installed."
fi

# Install Ansible if not already installed
if ! command_exists ansible; then
    echo "Ansible is not installed. Installing Ansible..."
    brew install ansible
else
    echo "Ansible is already installed."
fi

# Change to the Working_Solution/3 directory and run Vagrant commands
cd ./Working_Solution/3/
echo -e "${RED}Be aware!${NC} This solution may require a manual intervention to complete the installation."
vagrant up
vagrant provision

# Change to the Working_Solution/1 directory and run Vagrant commands
cd ../1/
vagrant up
vagrant provision

# Change to the Working_Solution/2 directory and run Vagrant commands
cd ../2/
vagrant up
vagrant provision

