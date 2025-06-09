#!/bin/bash

set -e

echo "🔐 Purple Team Lab Environment Setup"
echo "====================================="
echo ""
echo "Select components to deploy:"
echo "1) Red Team Target (Ubuntu + vulnerable apps)"
echo "2) Blue Team Target (Windows 11 + Defender/Sysmon)"
echo "3) Purple Team (macOS via UTM manual step)"
echo "4) Windows Domain Controller"
echo "5) Vulnerable VM Import (e.g., VulnHub OVA/ISO)"
echo "6) All of the above"
echo ""

read -p "Enter your choice(s) (e.g. 1 2 5): " choices

# Base install requirements
install_dependencies() {
  echo "🔧 Installing core dependencies..."
  sudo dnf install -y qemu-kvm virt-manager libvirt bridge-utils     spice-gtk swtpm edk2-ovmf genisoimage wget unzip     docker podman
  sudo systemctl enable --now libvirtd
}

setup_network_bridge() {
  echo "🌐 Setting up bridge network 'br0'..."
  sudo nmcli connection add type bridge ifname br0 con-name br0
  sudo nmcli connection modify br0 ipv4.method manual ipv4.addresses 192.168.99.1/24
  sudo nmcli connection up br0
}

setup_bridge_slave() {
  echo "🧷 Bind physical NIC to bridge..."
  read -p "Enter your physical network interface (e.g., enp0s31f6): " nic
  sudo nmcli connection add type ethernet con-name bridge-slave ifname $nic master br0
}

create_red_vm() {
  echo "🔴 Creating Red Team Ubuntu VM..."
  wget -nc https://releases.ubuntu.com/22.04/ubuntu-22.04.4-live-server-amd64.iso
  virt-install --name red-ubuntu     --memory 4096 --vcpus 2     --disk path=/var/lib/libvirt/images/red-ubuntu.qcow2,size=25     --cdrom ./ubuntu-22.04.4-live-server-amd64.iso     --os-variant ubuntu22.04 --network bridge=br0     --graphics spice --boot useserial=on --noautoconsole
}

create_blue_vm() {
  echo "🟢 Creating Blue Team Windows VM..."
  echo "➡️  You will need a Windows ISO and VirtIO drivers ISO."
  read -p "Enter path to Windows ISO: " winiso
  read -p "Enter path to VirtIO ISO: " virtioiso
  virt-install --name blue-windows     --memory 6144 --vcpus 4     --disk path=/var/lib/libvirt/images/blue-windows.qcow2,size=50     --cdrom "$winiso"     --disk "$virtioiso",device=cdrom     --os-variant win10 --network bridge=br0     --graphics spice --boot useserial=on --noautoconsole
}

create_dc_vm() {
  echo "🧿 Creating Windows Domain Controller..."
  read -p "Enter path to Windows Server ISO: " winserveriso
  virt-install --name domain-controller     --memory 8192 --vcpus 4     --disk path=/var/lib/libvirt/images/domain-controller.qcow2,size=60     --cdrom "$winserveriso"     --os-variant win2k19 --network bridge=br0     --graphics spice --boot useserial=on --noautoconsole
}

import_vulnhub_vm() {
  echo "📦 Importing VulnHub OVA/ISO..."
  read -p "Enter full path to .ova or .iso file: " vulnpath
  extension="${vulnpath##*.}"
  if [ "$extension" == "ova" ]; then
    echo "🔧 Extracting and importing OVA..."
    mkdir -p ~/vulnhub-vms/tmp
    tar -xf "$vulnpath" -C ~/vulnhub-vms/tmp
    ovafile=$(find ~/vulnhub-vms/tmp -name "*.ovf")
    virt-import --name vulnhub-import       --memory 2048 --vcpus 2       --disk ~/vulnhub-vms/tmp/*.vmdk       --os-variant generic       --network bridge=br0 --graphics spice
  else
    echo "⚙️ Starting ISO-based VM install..."
    virt-install --name vulnhub-vm       --memory 2048 --vcpus 2       --disk path=/var/lib/libvirt/images/vulnhub-vm.qcow2,size=20       --cdrom "$vulnpath"       --os-variant generic --network bridge=br0       --graphics spice --boot useserial=on --noautoconsole
  fi
}

# Loop through choices
install_dependencies
setup_network_bridge
setup_bridge_slave

for choice in $choices; do
  case $choice in
    1) create_red_vm ;;
    2) create_blue_vm ;;
    3) echo "🧬 macOS VM setup is manual via UTM: https://mac.getutm.app" ;;
    4) create_dc_vm ;;
    5) import_vulnhub_vm ;;
    6)
      create_red_vm
      create_blue_vm
      create_dc_vm
      import_vulnhub_vm
      echo "🧬 Reminder: macOS VM setup is manual via UTM."
      ;;
    *) echo "❌ Invalid choice: $choice" ;;
  esac
done

echo "✅ Lab deployment script complete."
