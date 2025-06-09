#!/bin/bash

echo "=== Cyber Lab /etc/hosts Auto-Updater ==="

OUTPUT_FILE="./cyberlab.hosts"
VMS=("kali" "msf2" "msf3linux" "msf3win" "winserver")

echo "[*] Generating hosts entries..."
echo "# Cyber Lab VM IP mappings" > "$OUTPUT_FILE"

for vm in "${VMS[@]}"; do
  echo -n "[*] Getting IP for $vm... "
  ip=$(vagrant ssh "$vm" -c "hostname -I | awk '{print $1}'" 2>/dev/null | tr -d '\r')
  if [[ -n "$ip" ]]; then
    echo "$ip $vm.local" >> "$OUTPUT_FILE"
    echo "$ip"
  else
    echo "unavailable"
  fi
done

echo ""
read -p "[?] Append entries to /etc/hosts? (y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo "[*] Backing up /etc/hosts to /etc/hosts.bak..."
  sudo cp /etc/hosts /etc/hosts.bak

  echo "[*] Appending entries..."
  sudo bash -c "cat $OUTPUT_FILE >> /etc/hosts"

  echo "[✓] Done. Entries added to /etc/hosts"
else
  echo "[*] Skipped /etc/hosts update. Entries saved in: $OUTPUT_FILE"
fi
