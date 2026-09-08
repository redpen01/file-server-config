# Syncthing Ansible Role

Deploys Syncthing (continuous file synchronization) using Podman in rootless mode.

## Variables

### Required Variables
Define at runtime (e.g., via `--extra-vars` or in a vars file):

| Variable | Description |
| :--- | :--- |
| `syncthing_storage_path` | Absolute path for data and configuration storage (user-provided at runtime, owned by the target user). |

> **Note:** The role automatically creates `{{ syncthing_storage_path }}` and `{{ syncthing_storage_path }}/data` with container SELinux context (`container_file_t`) and mounts `/data` to `/var/syncthing:Z`.

### Optional Variables

| Variable | Default | Description |
| :--- | :--- | :--- |
| `syncthing_web_port` | `8384` | Host port for the Syncthing web GUI. |
| `syncthing_listen_port` | `22000` | Host port for the sync protocol (TCP/UDP). |
| `syncthing_config_dir` | `~/.config/containers/syncthing` | Target directory for the generated `podman-compose.yml`. |

## Prerequisites

For rootless containers to stay active across user logouts, enable user lingering on the target host:

```bash
loginctl enable-linger <username>
```

## Usage

Run with the main services deployment playbook using the `syncthing` tag:

```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy_services.yml \
  --tags syncthing \
  -e "syncthing_storage_path=/home/username/sync"
```

To customize network ports:

```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy_services.yml \
  --tags syncthing \
  -e "syncthing_storage_path=/home/username/sync" \
  -e "syncthing_web_port=8384" \
  -e "syncthing_listen_port=22000"
```
