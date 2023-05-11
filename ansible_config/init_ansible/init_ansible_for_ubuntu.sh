#!/bin/bash

# If you need Ansible-lint
echo "If you need Ansible-lint enter (y/n):"
read ansible_lint_var

# If you need pre-commit
echo "If you need pre-commit enter (y/n):"
read pre_commit_var

echo "Install Ansible from ppa:ansible/ansible and python3-pip"

# Install Ansible from ppa:ansible/ansible
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible python3-pip -y

echo "---------------------------------------------"
ansible --version
echo "---------------------------------------------"

if [ $ansible_lint_var == "y" ]; then
    pip3 install ansible-lint
fi

if [ $pre_commit_var == "y" ]; then
    pip3 install pre-commit
fi
