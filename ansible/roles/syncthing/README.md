# Syncthing Ansible Role

Deploys Syncthing (Continuous file synchronization) using Podman in rootless mode.

## Required Variables
Define these at runtime (e.g., in a vars file or via `--extra-vars`):

| Variable | Description |
| :--- | :--- |
| `syncthing_storage_path` | Absolute path for data and configuration storage (should be owned by the user running the playbook). |
| `syncthing_web_port` | Host port for the Syncthing web GUI. |
| `syncthing_listen_port` | Host port for the sync protocol (TCP/UDP). |

## Usage
Run with the main playbook using tags. Note: This playbook should be run as your user (not root).

```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy_services.yml \
  --tags syncthing \
  -e "syncthing_storage_path=/home/username/sync" \
  -e "syncthing_web_port=8384" \
  -e "syncthing_listen_port=22000"
```
