# 🧪 Fedora Purple Team Cyber Lab

This repo contains a script to deploy a complete **red team / blue team / purple team** lab on your **Fedora-based Framework laptop** using **local virtualization (KVM/QEMU)**. It's designed for high-performance local security testing and learning environments.

---

## ⚙️ Features

- 🧨 Red Team (Ubuntu + vulnerable services)
- 🛡️ Blue Team (Windows 11 + Defender/Sysmon)
- 🧬 Purple Team (macOS via UTM – manual step)
- 🧿 Windows AD/Domain Controller
- 📦 VulnHub VM importer (.ova/.iso support)
- 🧰 Local bridge network support
- 📍 Run all VMs using `virt-manager` or CLI

---

## 🚀 Usage

### 1. Download & Run

```bash
chmod +x setup_cyber_lab.sh
./setup_cyber_lab.sh
```

### 2. Select Components to Deploy

You’ll be prompted to choose:
```
1) Red Team Target (Ubuntu)
2) Blue Team Target (Windows 11)
3) Purple Team Target (macOS manual)
4) Windows Domain Controller (Server)
5) VulnHub VM Import
6) All of the above
```

---

## 🧠 Prerequisites

- Fedora 40+ with:
  - QEMU/KVM
  - virt-manager
  - Bridge networking support
- Sufficient hardware (you likely have this):
  - 96GB RAM
  - Ryzen 9 7940HS
  - WD_BLACK NVMe SSD
  - Radeon RX 7700S

---

## 📥 VM Assets Required

Some components require manual downloads:
- ✅ Ubuntu ISO: https://ubuntu.com/download/server
- ✅ Windows 11 ISO: https://www.microsoft.com/software-download/windows11
- ✅ VirtIO drivers: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/
- ✅ Windows Server ISO (2019+)
- ✅ VulnHub images (e.g. .ova): https://www.vulnhub.com/

---

## 🧬 macOS (Manual Setup)

Use [UTM](https://mac.getutm.app/) to run macOS VMs safely and easily on Fedora.
> macOS virtualization with QEMU directly is complex and not covered by this script.

---

## 🗃️ Directory Layout

```
fedora-cyber-lab/
├── setup_cyber_lab.sh     # Main lab setup script
├── README.md              # This file
├── .gitignore             # Ignore build logs and cache
├── LICENSE                # MIT License
```

---

## 🔒 License

MIT License. Free to use, adapt, and extend.

---

## ✉️ Maintainer

**Austin Dunn**  
Principal Security Engineer  
[Your GitHub/contact here]
