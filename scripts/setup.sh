#!/bin/bash

set -e

echo "[*] Updating system packages..."
sudo apt update && sudo apt install -y \
    vagrant \
    virtualbox \
    virtualbox-ext-pack \
    ansible \
    unzip \
    git \
    curl \
    wget \
    python3-pip \
    libvirt-daemon-system \
    qemu-kvm

echo "[*] Installing required Vagrant plugins..."
vagrant plugin install vagrant-winrm vagrant-winrm-syncedfolders



echo "[*] Setup complete. You can now run:"
echo "    vagrant up"
