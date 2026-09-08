# Ansible Playbooks & Service Deployment Guide

This directory contains Ansible playbooks and roles for provisioning the file server, configuring storage and sharing protocols, and deploying rootless containerized services.

---

## Playbook Overview

| Playbook | Purpose | Execution Mode |
| :--- | :--- | :--- |
| [`baseline_setup.yml`](baseline_setup.yml) | Installs foundational system packages (EPEL, Git, htop, curl, SELinux tools). | `become: true` |
| [`storage_config.yml`](storage_config.yml) | Provisions shared storage (`/mnt/data`), sets group permissions (`2775`), configures Samba & SFTP (`002` umask), enables SELinux booleans, and configures firewall rules. | `become: true` |
| [`deploy_services.yml`](deploy_services.yml) | Orchestrates modular container service deployment using Podman in rootless mode via role tags. | User / Rootless (`become: false` in service roles) |
| [`extract_state.yml`](extract_state.yml) | Audits and extracts live Samba configuration and filesystem state into structured YAML facts (`vars/generated_vars.yml`). | `become: true` |

---

## Setup & Prerequisites

1. **Install Ansible Collections**:
   Install required collections from [`requirements.yml`](requirements.yml):
   ```bash
   ansible-galaxy install -r ansible/requirements.yml
   ```

2. **Automated Bootstrap (Optional)**:
   Run [`bootstrap.sh`](bootstrap.sh) to install dependencies and execute the baseline and storage playbooks:
   ```bash
   ./ansible/bootstrap.sh
   ```

3. **Enable User Lingering (For Rootless Containers)**:
   Ensure your user account can maintain persistent rootless Podman services after disconnecting:
   ```bash
   loginctl enable-linger <username>
   ```

---

## Running Playbooks

### 1. Baseline System Setup
Installs essential system tools and repositories:
```bash
ansible-playbook -i ansible/inventory.ini ansible/baseline_setup.yml --ask-become-pass
```

### 2. Storage & Sharing Configuration
Provisions group permissions, Samba shares, SFTP umask, and SELinux contexts:
```bash
ansible-playbook -i ansible/inventory.ini ansible/storage_config.yml --ask-become-pass
```

### 3. Service Deployments ([`deploy_services.yml`](deploy_services.yml))

#### Deploy Syncthing
Deploys rootless Syncthing with runtime storage path:
```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy_services.yml \
  --tags syncthing \
  -e "syncthing_storage_path=/home/username/sync"
```
*(Optional port overrides: `-e "syncthing_web_port=8384 -e syncthing_listen_port=22000"`)*

#### Deploy Immich
Deploys rootless Immich photo/video management:
```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy_services.yml \
  --tags immich \
  -e "immich_storage_path=/home/username/photos" \
  -e "immich_port=2283"
```

---

## Roles Reference

- [**Syncthing Role Documentation**](roles/syncthing/README.md)
- [**Immich Role Documentation**](roles/immich/README.md)
