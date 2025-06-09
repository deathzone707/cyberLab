#!/bin/bash

echo "=== [*] Cyber Lab Smoke Test ==="

# --- Test Podman Containers
echo "[*] Checking Podman containers..."
containers=("dvwa" "juice-shop")

for container in "${containers[@]}"; do
  echo -n "    - $container: "
  if podman ps --format '{{.Names}}' | grep -q "$container"; then
    echo "✓ running"
  else
    echo "✗ not running"
  fi
done

# --- Test Container Web Interfaces
echo "[*] Testing HTTP endpoints..."
declare -A urls=(
  [dvwa]="http://localhost:8081"
  [juice-shop]="http://localhost:8082"
)

for name in "${!urls[@]}"; do
  url="${urls[$name]}"
  echo -n "    - $name @ $url: "
  if curl -s -o /dev/null -w "%{http_code}" "$url" | grep -q "200"; then
    echo "✓ reachable"
  else
    echo "✗ failed"
  fi
done

# --- Ping Lab VMs
echo "[*] Pinging VMs..."
vms=("msf2" "msf3linux" "msf3win" "winserver")

for vm in "${vms[@]}"; do
  echo -n "    - $vm.local: "
  if ping -c 1 -W 1 "${vm}.local" > /dev/null 2>&1; then
    echo "✓ alive"
  else
    echo "✗ unreachable"
  fi
done

echo "[✓] Smoke test complete."
