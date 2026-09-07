# Immich Ansible Role

## Variables Required
This role requires the following variables to be defined at runtime (e.g., via `extra-vars`):

- `immich_storage_path`: Base directory on the host for Immich data.
- `immich_user`: System user to run the container.
- `immich_group`: System group to run the container.
- `immich_port`: Port for the web interface.

## Usage
Run the role using the main playbook, providing variables:
`ansible-playbook -i inventory.ini deploy_services.yml -e "immich_storage_path=/path/to/data immich_user=immichuser ..."`
