# Syncthing Ansible Role

## Variables Required
This role requires the following variables to be defined at runtime (e.g., via `extra-vars`):

- `syncthing_storage_path`: Base directory on the host for Syncthing data.
- `syncthing_user`: System user to run the container.
- `syncthing_group`: System group to run the container.
- `syncthing_web_port`: Port for the web interface.
- `syncthing_listen_port`: Port for Syncthing synchronization protocol.

## Usage
Run the role using the main playbook, providing variables:
`ansible-playbook -i inventory.ini deploy_services.yml -e "syncthing_storage_path=/path/to/data syncthing_user=syncuser ..."`
