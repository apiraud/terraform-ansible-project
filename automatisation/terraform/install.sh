#!/bin/sh

class="$1"
name="$2"

# Verifier si un argument a ete passe en parametre
if [ -z "$class" ] || [ -z "$name" ]; then
  echo "Usage: $0 <class> <name>"
  exit 1
fi

sleep 10

ANSIBLE_HOST_KEY_CHECKING=False /automatisation/ansible/.venv/bin/ansible-playbook -i /automatisation/ansible/inventory/inventory.yaml /automatisation/ansible/playbook/install_packages.yaml -l $name
ANSIBLE_HOST_KEY_CHECKING=False /automatisation/ansible/.venv/bin/ansible-playbook -i /automatisation/ansible/inventory/inventory.yaml /automatisation/ansible/playbook/install_users.yaml -l $name

if [ "$class" = "websites" ]; then
  ANSIBLE_HOST_KEY_CHECKING=False /automatisation/ansible/.venv/bin/ansible-playbook -i /automatisation/ansible/inventory/inventory.yaml /automatisation/ansible/playbook/copy_files.yaml -l $name
fi

if [ "$class" = "bdd" ]; then
  ANSIBLE_HOST_KEY_CHECKING=False /automatisation/ansible/.venv/bin/ansible-playbook -i /automatisation/ansible/inventory/inventory.yaml /automatisation/ansible/playbook/configure_bdd.yaml -l $name
fi
