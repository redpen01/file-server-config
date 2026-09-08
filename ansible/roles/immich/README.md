# Immich Ansible Role

Deploys Immich (high-performance self-hosted photo and video management solution) using Podman in rootless mode.

## Variables

### Required Variables
Define at runtime (e.g., via `--extra-vars` or in a vars file):

| Variable | Description |
| :--- | :--- |
| `immich_storage_path` | Absolute path for library and database storage (user-provided at runtime, owned by the target user). |

> **Note:** The role automatically creates `{{ immich_storage_path }}`, `{{ immich_storage_path }}/library`, and `{{ immich_storage_path }}/postgres` with container SELinux context (`container_file_t`) and mounts the library to `/usr/src/app/upload:Z`.

### Optional Variables

| Variable | Default | Description |
| :--- | :--- | :--- |
| `immich_port` | `2283` | Host port to expose the Immich web interface. |
| `immich_uid` | `ansible_user_uid` (1000) | User UID passed into container environment (`PUID`). |
| `immich_gid` | `ansible_user_gid` (1000) | Group GID passed into container environment (`PGID`). |
| `immich_config_dir` | `~/.config/containers/immich` | Target directory for the generated `podman-compose.yml`. |

## Prerequisites

For rootless containers to remain active across user logouts, enable user lingering on the target host:

```bash
loginctl enable-linger <username>
```

## Usage

Run with the main services deployment playbook using the `immich` tag:

```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy_services.yml \
  --tags immich \
  -e "immich_storage_path=/home/username/photos"
```

To customize the port:

```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy_services.yml \
  --tags immich \
  -e "immich_storage_path=/home/username/photos" \
  -e "immich_port=2283"
```
