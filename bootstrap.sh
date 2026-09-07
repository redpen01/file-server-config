#!/usr/bin/env bash
set -e

# Auto-install collection dependencies first
ansible-galaxy install -r requirements.yml

# Run playbooks
ansible-playbook baseline_setup.yml "$@"
ansible-playbook storage_config.yml "$@"
