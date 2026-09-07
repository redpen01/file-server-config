# Syncthing Ansible Role

Deploys Syncthing (Continuous file synchronization) using Podman.

## Required Variables
Define these at runtime (e.g., in a vars file or via `--extra-vars`):

| Variable | Description |
| :--- | :--- |
| `syncthing_storage_path` | Absolute path for data and configuration storage. |
| `syncthing_user` | System user that will own the storage and run the container. |
| `syncthing_group` | System group that will own the storage. |
| `syncthing_web_port` | Host port for the Syncthing web GUI. |
| `syncthing_listen_port` | Host port for the sync protocol (TCP/UDP). |

## Usage
Run with the main playbook using tags:

```bash
ansible-playbook -i inventory.ini deploy_services.yml \
  --tags syncthing \
  -e "syncthing_storage_path=/mnt/sync" \
  -e "syncthing_user=syncthing" \
  -e "syncthing_group=syncthing" \
  -e "syncthing_web_port=8384" \
  -e "syncthing_listen_port=22000"
```
