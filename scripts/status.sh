#!/bin/bash

echo "=== Cyber Lab VM Status Check ==="

echo "[*] Checking Vagrant VM statuses..."
vagrant status

echo ""
echo "[*] Checking host reachability (local DHCP network)..."
hosts=("kali" "msf2" "msf3linux" "msf3win" "winserver")

for host in "${hosts[@]}"; do
  echo -n "Pinging ${host}.local... "
  if ping -c 1 -W 1 ${host}.local > /dev/null 2>&1; then
    echo "✓ Reachable"
  else
    echo "✗ Unreachable"
  fi
done
