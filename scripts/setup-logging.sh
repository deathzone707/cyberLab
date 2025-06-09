#!/bin/bash

echo "=== [*] Initializing Log Directory for Cyber Lab Containers ==="

LOG_DIR="/home/vagrant/logs"
CONTAINERS=("dvwa" "juice-shop")

# Create logging directory
mkdir -p $LOG_DIR

# Apply permissions
chown vagrant:vagrant $LOG_DIR
chmod 755 $LOG_DIR

# Check and update logging driver (Podman logs to journald by default)
echo "[*] Reconfiguring containers to log to files..."

for container in "${CONTAINERS[@]}"; do
  echo "[*] Handling $container..."
  podman stop $container || true
  podman rm $container || true

  podman run -d \
    --name $container \
    --log-driver k8s-file \
    --log-opt path=$LOG_DIR/${container}.log \
    -p $(if [[ "$container" == "dvwa" ]]; then echo "8081:80"; else echo "8082:3000"; fi) \
    $(if [[ "$container" == "dvwa" ]]; then echo "vulnerables/web-dvwa"; else echo "bkimminich/juice-shop"; fi)
done

echo "[✓] Logging setup complete. Logs are in: $LOG_DIR"
