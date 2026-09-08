# Amended Modular Service Deployment Plan: Android-Focused Backup

## Objective
Establish a repeatable, modular IaC setup for deploying Immich and Syncthing on AlmaLinux 9 using **rootless Podman**. The primary requirement is **robust, automated backup of photos and videos from Android devices** on the LAN.

## Scope & Impact
- **Primary Goal:** Automated Android photo/video backup.
- **Secondary Goal:** General file synchronization.
- **Target System:** AlmaLinux 9.
- **Containerization:** Podman (Rootless mode).
- **Configuration Management:** Ansible.
- **Service Management:** `systemd --user` with `loginctl enable-linger` for persistence.

## Proposed Architecture
- **Ansible Roles:** Encapsulate service-specific configuration (`ansible/roles/immich/`, `ansible/roles/syncthing/`).
- **Orchestration:** Use a single playbook (`ansible/deploy_services.yml`) to manage deployment via tags.
- **Container Configuration:** Store configuration (e.g., `podman-compose.yml.j2`) within the roles.
- **Execution Mode:** All tasks are executed as the standard user (no `become: true` for container management tasks), storing configurations in `~/.config/containers/`.

## Implementation Status
1.  **Research & Preparation:** Android client compatibility, required server-side networking, and storage mappings defined.
2.  **Role Creation:** Setup `ansible/roles/immich/` and `ansible/roles/syncthing/` with `README.md` documenting required runtime variables.
3.  **Playbook Integration:** `ansible/deploy_services.yml` created for service orchestration.
4.  **Rootless Adaptation:** All roles updated for rootless execution; persistent service management instructions documented.

## Android-Focused Verification Criteria
- **Immich:** Verify successful installation of the Android app, successful photo/video backup, and library indexing.
- **Syncthing:** Verify successful setup of folder pairs (Android -> Server) and consistent, background synchronization of photo/video folders.

## Operational Notes
- **Persistence:** Ensure `sudo loginctl enable-linger <username>` is run on the server for automated container startup at boot.
- **Portability:** For maximum data sovereignty, consider using Immich's "External Library" feature to maintain your own folder structure rather than standard uploads.
