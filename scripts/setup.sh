#!/bin/bash

set -e

echo "[*] Updating system packages..."
sudo apt update && sudo apt install -y \
    vagrant \
    virtualbox \
    virtualbox-ext-pack \
    ansible \
    packer \
    unzip \
    git \
    curl \
    wget \
    python3-pip \
    libvirt-daemon-system \
    qemu-kvm

echo "[*] Installing required Vagrant plugins..."
vagrant plugin install vagrant-winrm vagrant-winrm-syncedfolders

echo "[*] Cloning Metasploitable 3 repository..."
if [ ! -d "metasploitable3" ]; then
  git clone https://github.com/rapid7/metasploitable3.git
  cd metasploitable3
else
  cd metasploitable3
  git pull
fi

echo "[*] Installing Packer and Vagrant dependencies..."
vagrant box list | grep "metasploitable3" || echo "No metasploitable3 boxes yet"

echo "[*] Building Metasploitable 3 Windows box..."
PACKER_BUILDER_TYPE=virtualbox-iso packer build windows_2008_r2.json

echo "[*] Adding Metasploitable 3 Windows box to Vagrant..."
vagrant box add metasploitable3-win windows_2008_r2_virtualbox.box --force

echo "[*] Building Metasploitable 3 Ubuntu box..."
PACKER_BUILDER_TYPE=virtualbox-iso packer build ubuntu_1404.json

echo "[*] Adding Metasploitable 3 Ubuntu box to Vagrant..."
vagrant box add metasploitable3-linux ubuntu_1404_virtualbox.box --force

cd ..

echo "[*] Setup complete. You can now run:"
echo "    vagrant up"
