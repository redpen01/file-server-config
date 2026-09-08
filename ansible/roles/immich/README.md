# Immich Ansible Role

Deploys Immich (High-performance self-hosted photo and video management solution) using Podman in rootless mode.

## Required Variables
Define these at runtime (e.g., in a vars file or via `--extra-vars`):

| Variable | Description |
| :--- | :--- |
| `immich_storage_path` | Absolute path for library and database storage (should be owned by the user running the playbook). |
| `immich_port` | Host port to expose the Immich web interface. |

## Usage
Run with the main playbook using tags. Note: This playbook should be run as your user (not root).

```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy_services.yml \
  --tags immich \
  -e "immich_storage_path=/home/username/photos" \
  -e "immich_port=2283"
```
