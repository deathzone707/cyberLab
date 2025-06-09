#!/bin/bash

echo "=== Cyber Lab Launcher ==="
echo "Choose a lab group to launch:"
echo "1) Red Team (Kali only)"
echo "2) Target VMs (Metasploitable2/3 only)"
echo "3) AD Lab (Windows Server only)"
echo "4) Full Lab (All VMs)"
echo "5) Exit"

read -p "Enter selection [1-5]: " choice

case $choice in
  1)
    echo "[*] Starting Red Team (Kali)..."
    vagrant up kali
    ;;
  2)
    echo "[*] Starting Targets (Metasploitable)..."
    vagrant up metasploitable2 metasploitable3-linux metasploitable3-windows
    ;;
  3)
    echo "[*] Starting AD Lab (Windows Server)..."
    vagrant up winserver
    ;;
  4)
    echo "[*] Starting Full Lab..."
    vagrant up
    ;;
  5)
    echo "Goodbye!"
    exit 0
    ;;
  *)
    echo "[!] Invalid option. Please select 1-5."
    ;;
esac
