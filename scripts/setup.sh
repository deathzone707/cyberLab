#!/bin/bash

set -e

packages=(
    vagrant
    virtualbox
    virtualbox-ext-pack
    ansible
    packer
    unzip
    git
    curl
    wget
    python3-pip
    libvirt-daemon-system
    qemu-kvm
)

echo "[*] Detecting package manager..."
if command -v apt >/dev/null 2>&1; then
    PM="apt"
elif command -v dnf >/dev/null 2>&1; then
    PM="dnf"
elif command -v yum >/dev/null 2>&1; then
    PM="yum"
elif command -v pacman >/dev/null 2>&1; then
    PM="pacman"
else
    echo "Unsupported distribution. Please install dependencies manually." >&2
    exit 1
fi

echo "[*] Updating system packages and installing dependencies using $PM..."
case "$PM" in
    apt)
        sudo apt update
        sudo apt install -y "${packages[@]}"
        ;;
    dnf|yum)
        sudo "$PM" install -y "${packages[@]}"
        ;;
    pacman)
        sudo pacman -Sy --noconfirm "${packages[@]}"
        ;;
esac

echo "[*] Installing required Vagrant plugins..."
vagrant plugin install vagrant-winrm vagrant-winrm-syncedfolders



echo "[*] Setup complete. You can now run:"
echo "    vagrant up"
