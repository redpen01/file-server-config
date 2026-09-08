# Immich Ansible Role

Deploys Immich (high-performance self-hosted photo and video management solution) using Podman in rootless mode.

## Variables

### Required Variables
Define at runtime (e.g., via `--extra-vars` or in a vars file):

| Variable | Description |
| :--- | :--- |
| `immich_storage_path` | Absolute path for library and database storage (owned by the target user). |
| `immich_port` | Host port to expose the Immich web interface (e.g., `2283`). |

### Optional Variables

| Variable | Default | Description |
| :--- | :--- | :--- |
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
  -e "immich_storage_path=/home/username/photos" \
  -e "immich_port=2283"
```
