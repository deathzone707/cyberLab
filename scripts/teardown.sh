#!/bin/bash

echo "[*] Shutting down and destroying all Vagrant VMs..."
vagrant halt
vagrant destroy -f

read -p "[?] Do you want to delete all saved Vagrant boxes for Metasploitable 3? (y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo "[*] Removing Metasploitable 3 boxes..."
  vagrant box remove metasploitable3-win --force
  vagrant box remove metasploitable3-linux --force
fi

read -p "[?] Delete cloned metasploitable3/ directory? (y/N): " delrepo
if [[ "$delrepo" =~ ^[Yy]$ ]]; then
  echo "[*] Deleting metasploitable3 repository..."
  rm -rf metasploitable3
fi

echo "[*] Teardown complete."
