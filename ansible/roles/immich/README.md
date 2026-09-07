# Immich Ansible Role

Deploys Immich (High-performance self-hosted photo and video management solution) using Podman.

## Required Variables
Define these at runtime (e.g., in a vars file or via `--extra-vars`):

| Variable | Description |
| :--- | :--- |
| `immich_storage_path` | Absolute path for library and database storage. |
| `immich_user` | System user that will own the storage and run containers. |
| `immich_group` | System group that will own the storage. |
| `immich_port` | Host port to expose the Immich web interface. |

## Usage
Run with the main playbook using tags:

```bash
ansible-playbook -i inventory.ini deploy_services.yml \
  --tags immich \
  -e "immich_storage_path=/mnt/photos" \
  -e "immich_user=immich" \
  -e "immich_group=immich" \
  -e "immich_port=2283"
```
