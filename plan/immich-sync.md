# Amended Modular Service Deployment Plan: Android-Focused Backup

## Objective
Establish a repeatable, modular IaC setup for deploying Immich and Syncthing on AlmaLinux 9 using Podman. The primary requirement is **robust, automated backup of photos and videos from Android devices** on the LAN. General file synchronization is a secondary capability.

## Scope & Impact
- **Primary Goal:** Automated Android photo/video backup.
- **Secondary Goal:** General file synchronization.
- **Target System:** AlmaLinux 9.
- **Containerization:** Podman.
- **Configuration Management:** Ansible.

## Proposed Architecture
- **Ansible Roles:** Encapsulate service-specific configuration (`ansible/roles/immich/`, `ansible/roles/syncthing/`).
- **Orchestration:** Use a single playbook (`ansible/deploy_services.yml`) to manage deployment via tags, allowing you to toggle/test either service.
- **Container Configuration:** Store configuration (e.g., `podman-compose.yml`) within the roles.

## Implementation Steps
1.  **Research & Preparation:** Research Android client compatibility, required server-side networking, and storage mappings for both Immich and Syncthing specifically for photo/video backup workflows.
2.  **Role Creation:** Setup `ansible/roles/immich/` and `ansible/roles/syncthing/`. Define common variables (e.g., base storage paths, network settings) in `ansible/group_vars/all.yml`.
3.  **Playbook Integration:** Create `ansible/deploy_services.yml` for service orchestration.
4.  **Verification:** Test deployment, Android client connectivity, and automated backup functionality for both services.

## Android-Focused Verification Criteria
- **Immich:** Verify successful installation of the Android app, successful photo/video backup, and library indexing.
- **Syncthing:** Verify successful setup of folder pairs (Android -> Server) and consistent, background synchronization of photo/video folders.

## Cleanup/Teardown Strategy
- Dedicated teardown tasks in Ansible roles ensure clean removal of containers, preserving or removing data as defined by your configuration.
